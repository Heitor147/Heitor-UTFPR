#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Wiktionary Mass Exporter - Production Version (v2)
Exporta artigos da Wiktionary em larga escala com suporte a categorias, filtros e controle de profundidade.

Principais correções desta versão:
- Tracking agora é persistente POR CATEGORIA (não gera um arquivo novo a cada execução).
  Isso é o que faz o "não reexportar página já feita" funcionar de verdade.
- Cache de templates em memória: cada template é buscado uma única vez por execução,
  em vez de uma vez por página que o referencia.
- OutputManager lê o tamanho real do arquivo existente ao reabrir, então o split
  por MAX_WORDS_PER_FILE continua correto mesmo reiniciando o processo no meio.
- Filtro de namespace menos agressivo (só descarta prefixos de namespace conhecidos,
  não qualquer título com ":").
- Logging consistente também no modo interativo (prints viram log também).
"""

import os
import re
import json
import time
import logging
import threading
from pathlib import Path
from typing import Set, List, Dict, Optional, Tuple
from collections import deque
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

import requests
from tqdm import tqdm

# ============================================================================
# CONFIGURAÇÃO
# ============================================================================

class Config:
    """Configuração centralizada da aplicação"""

    # API e requisições
    WIKTIONARY_API_URL = "https://en.wiktionary.org/w/api.php"
    USER_AGENT = "WiktionaryExporter/2.0 (+https://github.com/yourusername/wiktionary-exporter)"
    REQUEST_TIMEOUT = 30
    MAX_BATCH_SIZE = 50  # máximo de páginas por requisição em lotes
    MAX_RETRIES = 3
    RETRY_DELAY = 5.0

    # Controle de taxa de requisição: agora é um limite GLOBAL (compartilhado entre
    # threads) de requisições por segundo, em vez de um sleep fixo por requisição.
    # A API do Wiktionary/MediaWiki pede "não mais que uns poucos req/s" pra bots
    # sem permissão especial — 5/s é um valor respeitoso mas bem mais rápido que 1/s.
    MAX_REQUESTS_PER_SECOND = 5

    # Número de páginas processadas em paralelo (fetch de conteúdo + templates).
    # A escrita em arquivo continua sequencial (single-thread), só o I/O de rede
    # que é paralelizado. Não precisa ser maior que MAX_REQUESTS_PER_SECOND * 2,
    # aumentar além disso só cria threads ociosas esperando o rate limiter.
    MAX_WORKERS = 8

    # Namespaces conhecidos do MediaWiki que NÃO são artigos de verbete
    # (usado pra filtrar títulos com ":" que não são páginas normais)
    KNOWN_NAMESPACE_PREFIXES = [
        'wiktionary:', 'help:', 'appendix:', 'template:', 'category:',
        'module:', 'file:', 'mediawiki:', 'user:', 'talk:', 'special:',
        'thesaurus:', 'reconstruction:', 'citations:', 'index:', 'rhymes:'
    ]

    # Palavras-chave de inclusão padrão (sempre priorizadas)
    DEFAULT_INCLUDE_KEYWORDS = [
        'all topics',
        'appendices',
        'lemmas',
        'names',
        'phrases',
        'rhymes',
        'rhymes:',
        'symbols',
        'templates',
        'terms by etymology',
        'terms by usage',
        'varieties of'
    ]

    # Exportação
    MAX_WORDS_PER_FILE = 500000
    MAIN_NAMESPACE_ONLY = True
    EXPORT_TEMPLATE_SOURCES = True
    MAX_TEMPLATE_SOURCES_PER_PAGE = 12
    OUTPUT_DIR = "wiktionary_exports"

    # Tracking - agora por categoria, não por timestamp de execução.
    # Isso é o que permite retomar exportações sem reprocessar tudo.
    TRACKING_DIR = "wiktionary_tracking"

    # Logging - um log por dia é suficiente; não precisa de um arquivo por execução
    LOG_DIR = "logs"
    LOG_FILE = f"wiktionary_export_{datetime.now().strftime('%Y%m%d')}.log"

    @classmethod
    def ensure_directories(cls):
        """Cria diretórios necessários"""
        Path(cls.OUTPUT_DIR).mkdir(exist_ok=True)
        Path(cls.TRACKING_DIR).mkdir(exist_ok=True)
        Path(cls.LOG_DIR).mkdir(exist_ok=True)

    @classmethod
    def tracking_file_for(cls, category: str) -> str:
        """Nome do arquivo de tracking baseado na categoria (estável entre execuções)"""
        safe_name = re.sub(r'[^a-zA-Z0-9_-]+', '_', category.strip().lower())
        return os.path.join(cls.TRACKING_DIR, f"exported_{safe_name}.json")


# ============================================================================
# LOGGING
# ============================================================================

def setup_logging():
    """Configura sistema de logging"""
    Config.ensure_directories()
    log_path = os.path.join(Config.LOG_DIR, Config.LOG_FILE)

    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_path, encoding='utf-8'),
            logging.StreamHandler()
        ]
    )
    return logging.getLogger(__name__)


logger = setup_logging()


# ============================================================================
# GERENCIADOR DE TRACKING
# ============================================================================

class TrackingManager:
    """Gerencia quais artigos já foram exportados, persistente por categoria"""

    def __init__(self, category: str):
        Config.ensure_directories()
        self.tracking_file = Config.tracking_file_for(category)
        self.exported_pages: Set[str] = set()
        self.load_tracking()

    def load_tracking(self):
        """Carrega lista de páginas já exportadas"""
        if os.path.exists(self.tracking_file):
            try:
                with open(self.tracking_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    self.exported_pages = set(data.get('exported_pages', []))
                    logger.info(f"Carregadas {len(self.exported_pages)} páginas já exportadas de {self.tracking_file}")
            except Exception as e:
                logger.warning(f"Erro ao carregar tracking: {e}")
        else:
            logger.info(f"Nenhum tracking anterior encontrado, começando do zero ({self.tracking_file})")

    def save_tracking(self):
        """Salva lista de páginas exportadas"""
        try:
            with open(self.tracking_file, 'w', encoding='utf-8') as f:
                json.dump({
                    'exported_pages': sorted(self.exported_pages),
                    'timestamp': datetime.now().isoformat(),
                    'total': len(self.exported_pages)
                }, f, ensure_ascii=False, indent=2)
        except Exception as e:
            logger.error(f"Erro ao salvar tracking: {e}")

    def is_exported(self, page_title: str) -> bool:
        return page_title in self.exported_pages

    def mark_exported(self, page_title: str):
        self.exported_pages.add(page_title)

    def get_exported_count(self) -> int:
        return len(self.exported_pages)


# ============================================================================
# GERENCIADOR DE ARQUIVOS DE SAÍDA
# ============================================================================

class OutputManager:
    """Gerencia escrita em arquivos com split automático.

    Ao reabrir um arquivo existente (retomando uma exportação), lê a contagem
    real de palavras já escritas, em vez de assumir 0. Isso evita que o split
    por MAX_WORDS_PER_FILE fique incorreto entre execuções.
    """

    def __init__(self, category_name: str, section: Optional[str]):
        Config.ensure_directories()
        self.category_name = category_name.replace(" ", "_").replace("/", "_")
        self.section = section.replace(" ", "_") if section else "full_article"
        self.current_file_num = self._detect_last_file_num()
        self.current_word_count = self._count_words_in_current_file()
        self.current_file = None
        self.active = False
        self._open_new_file(append=True)

    def _filepath(self, num: int) -> str:
        filename = f"{self.category_name}_{self.section}_part{num}.txt"
        return os.path.join(Config.OUTPUT_DIR, filename)

    def _detect_last_file_num(self) -> int:
        """Encontra o maior número de parte já existente pra essa categoria/seção"""
        num = 1
        while os.path.exists(self._filepath(num + 1)):
            num += 1
        return num

    def _count_words_in_current_file(self) -> int:
        """Conta palavras já presentes no arquivo atual (se existir)"""
        path = self._filepath(self.current_file_num)
        if not os.path.exists(path):
            return 0
        try:
            with open(path, 'r', encoding='utf-8') as f:
                return len(f.read().split())
        except Exception as e:
            logger.warning(f"Não foi possível contar palavras existentes em {path}: {e}")
            return 0

    def _open_new_file(self, append: bool = False):
        """Abre arquivo de saída (append se já existir e estivermos retomando)"""
        if self.current_file is not None:
            self.current_file.close()

        filepath = self._filepath(self.current_file_num)
        mode = 'a' if append else 'w'
        self.current_file = open(filepath, mode, encoding='utf-8')
        self.active = True
        logger.info(f"Arquivo aberto ({'append' if append else 'novo'}): {filepath}")

    def write_article(self, title: str, content: str):
        """Escreve artigo no arquivo, faz split se necessário"""
        word_count = len(content.split())

        if self.current_word_count + word_count > Config.MAX_WORDS_PER_FILE:
            self.current_file_num += 1
            self.current_word_count = 0
            self._open_new_file(append=False)

        self.current_file.write(f"\n{'='*80}\n")
        self.current_file.write(f"TITLE: {title}\n")
        self.current_file.write(f"EXTRACTED: {datetime.now().isoformat()}\n")
        self.current_file.write(f"{'='*80}\n\n")
        self.current_file.write(content)
        self.current_file.write(f"\n\n")

        self.current_word_count += word_count
        self.current_file.flush()

    def close(self):
        if self.current_file:
            self.current_file.close()
            self.active = False
            logger.info(f"Arquivo fechado (total de palavras no arquivo atual: {self.current_word_count})")


# ============================================================================
# CLIENT DA API WIKTIONARY
# ============================================================================

class WikiApiClient:
    """Cliente para requisições à API MediaWiki (Wiktionary)"""

    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({'User-Agent': Config.USER_AGENT})
        # Cache de templates: cada template só é buscado uma vez na execução inteira,
        # em vez de uma vez por página que o referencia. Protegido por lock porque
        # múltiplas threads podem tentar buscar o mesmo template ao mesmo tempo.
        self._template_cache: Dict[str, Optional[str]] = {}
        self._template_cache_lock = threading.Lock()

        # Rate limiter de janela deslizante, compartilhado entre todas as threads.
        # Garante no máximo MAX_REQUESTS_PER_SECOND requisições por segundo no total,
        # não por thread — então paralelizar não estoura o limite de fato usado.
        self._rate_lock = threading.Lock()
        self._request_timestamps: deque = deque()

    def _throttle(self):
        """Bloqueia até haver uma 'vaga' na janela de 1s, de forma thread-safe"""
        while True:
            with self._rate_lock:
                now = time.time()
                # remove timestamps com mais de 1s
                while self._request_timestamps and now - self._request_timestamps[0] > 1.0:
                    self._request_timestamps.popleft()

                if len(self._request_timestamps) < Config.MAX_REQUESTS_PER_SECOND:
                    self._request_timestamps.append(now)
                    return

                # calcula quanto falta pro mais antigo "expirar" da janela
                wait_time = 1.0 - (now - self._request_timestamps[0])

            if wait_time > 0:
                time.sleep(wait_time)

    def _request_with_retry(self, params: Dict) -> Optional[Dict]:
        for attempt in range(Config.MAX_RETRIES):
            try:
                self._throttle()
                response = self.session.get(
                    Config.WIKTIONARY_API_URL,
                    params=params,
                    timeout=Config.REQUEST_TIMEOUT
                )
                response.raise_for_status()
                return response.json()
            except requests.RequestException as e:
                if attempt < Config.MAX_RETRIES - 1:
                    logger.warning(f"Erro na requisição (tentativa {attempt + 1}): {e}")
                    time.sleep(Config.RETRY_DELAY)
                else:
                    logger.error(f"Falha após {Config.MAX_RETRIES} tentativas: {e}")
                    return None

    def get_category_members(self, category: str, limit: int = 1000) -> List[str]:
        """Obtém membros de uma categoria"""
        members = []
        continue_token = None

        pbar = tqdm(desc=f"Carregando membros de '{category}'", unit=" membros")

        while len(members) < limit:
            params = {
                'action': 'query',
                'list': 'categorymembers',
                'cmtitle': f'Category:{category}',
                'cmtype': 'page|subcat',
                'cmlimit': 'max',
                'format': 'json'
            }
            if continue_token:
                params['cmcontinue'] = continue_token

            data = self._request_with_retry(params)
            if not data:
                break

            members_batch = data.get('query', {}).get('categorymembers', [])
            for member in members_batch:
                if len(members) >= limit:
                    break
                title = member.get('title', '')
                ns = member.get('ns', 0)
                if Config.MAIN_NAMESPACE_ONLY and ns not in (0, 14):
                    continue
                if ns == 0 and self._looks_like_non_article_namespace(title):
                    continue
                members.append(title)
                pbar.update(1)

            if 'continue' not in data:
                break
            continue_token = data['continue'].get('cmcontinue')

        pbar.close()
        return members[:limit]

    @staticmethod
    def _looks_like_non_article_namespace(title: str) -> bool:
        """Filtra apenas prefixos de namespace conhecidos, não qualquer ':'.

        Títulos reais de verbete podem conter ':' (ex: entradas de reconstrução
        listadas fora do namespace correspondente, símbolos, etc), então o filtro
        antigo (qualquer ':' descarta) era grosseiro demais.
        """
        if ':' not in title:
            return False
        prefix = title.split(':', 1)[0].strip().lower() + ':'
        return prefix in Config.KNOWN_NAMESPACE_PREFIXES

    def get_page_content(self, title: str) -> Optional[str]:
        return self._get_raw_wikitext(title)

    def _get_raw_wikitext(self, title: str) -> Optional[str]:
        params = {
            'action': 'query',
            'titles': title,
            'prop': 'revisions',
            'rvslots': 'main',
            'rvprop': 'content',
            'redirects': 1,
            'format': 'json'
        }

        data = self._request_with_retry(params)
        if not data:
            return None

        pages = data.get('query', {}).get('pages', {})
        for page_data in pages.values():
            revisions = page_data.get('revisions') or []
            if not revisions:
                continue
            rev = revisions[0]
            slots = rev.get('slots', {})
            main = slots.get('main', {}) if isinstance(slots, dict) else {}
            content = (
                main.get('*')
                or main.get('content')
                or rev.get('*')
                or rev.get('content')
            )
            if content:
                return content
        return None

    def _extract_template_names(self, wikitext: str) -> List[str]:
        names = []
        seen = set()
        for match in re.finditer(r'\{\{\s*([^\{\}\|\n]+)', wikitext):
            name = match.group(1).strip()
            if not name or name.startswith('#'):
                continue
            name = name.split('|', 1)[0].strip()
            name = name.split(':', 1)[0].strip()
            if not name:
                continue
            normalized = name.lower()
            if normalized in seen:
                continue
            seen.add(normalized)
            names.append(name)
        return names

    def get_template_sources(self, wikitext: str, max_templates: Optional[int] = None) -> str:
        """Retorna o wikitext bruto das templates referenciadas no texto.

        Usa cache em memória (self._template_cache): um template como
        {{en-noun}}, que aparece em milhares de verbetes, só é buscado
        na API uma vez por execução inteira.
        """
        limit = max_templates or Config.MAX_TEMPLATE_SOURCES_PER_PAGE
        template_names = self._extract_template_names(wikitext)[:limit]
        blocks = []

        for template_name in template_names:
            template_title = f"Template:{template_name}"

            with self._template_cache_lock:
                cached = template_title in self._template_cache
                template_text = self._template_cache.get(template_title)

            if not cached:
                template_text = self._get_raw_wikitext(template_title)
                with self._template_cache_lock:
                    self._template_cache[template_title] = template_text

            if not template_text:
                continue

            blocks.append(
                f"\n\n--- TEMPLATE SOURCE: {template_title} ---\n"
                f"{template_text.strip()}\n"
            )

        return ''.join(blocks)

    def get_page_section(self, title: str, section: Optional[str] = None, language: Optional[str] = None) -> Optional[str]:
        raw = self._get_raw_wikitext(title)
        if not raw:
            return None

        heading_re = re.compile(r'^(=+)\s*(.*?)\s*\1\s*$')
        lines = raw.splitlines()
        section_pattern = section.strip().lower() if section else None
        language_pattern = language.strip().lower() if language else None

        def heading_info(line: str):
            m = heading_re.match(line.strip())
            if not m:
                return None
            return len(m.group(1)), m.group(2).strip().lower()

        def collect_until(end_limit: int, start_idx: int, max_level: int) -> str:
            collected = []
            for idx in range(start_idx, end_limit):
                info = heading_info(lines[idx])
                if info and info[0] <= max_level:
                    break
                collected.append(lines[idx])
            return '\n'.join(collected).strip()

        def find_language_block(target_language: str):
            lang_start = None
            lang_end = len(lines)
            for idx, line in enumerate(lines):
                info = heading_info(line)
                if not info:
                    continue
                level, title_text = info
                if level != 2:
                    continue
                if title_text == target_language:
                    lang_start = idx + 1
                    continue
                if lang_start is not None:
                    lang_end = idx
                    break
            return lang_start, lang_end

        if section_pattern is None:
            if language_pattern:
                lang_start, lang_end = find_language_block(language_pattern)
                if lang_start is None:
                    return None
                return '\n'.join(lines[lang_start:lang_end]).strip() or None
            return raw.strip() or None

        search_start = 0
        search_end = len(lines)
        if language_pattern:
            lang_start, lang_end = find_language_block(language_pattern)
            if lang_start is None:
                return None
            search_start = lang_start
            search_end = lang_end

        section_start = None
        section_level = None
        for idx in range(search_start, search_end):
            info = heading_info(lines[idx])
            if not info:
                continue
            level, title_text = info
            if title_text == section_pattern:
                section_start = idx + 1
                section_level = level
                break

        if section_start is None:
            return None

        return collect_until(search_end, section_start, section_level) or None

    def get_pages_batch(self, titles: List[str]) -> Dict[str, str]:
        results = {}
        for i in tqdm(range(0, len(titles), Config.MAX_BATCH_SIZE), desc="Processando batch"):
            chunk = titles[i:i + Config.MAX_BATCH_SIZE]
            params = {
                'action': 'query',
                'titles': '|'.join(chunk),
                'prop': 'extracts',
                'explaintext': True,
                'format': 'json'
            }
            data = self._request_with_retry(params)
            if not data:
                continue
            pages = data.get('query', {}).get('pages', {})
            for page_data in pages.values():
                title = page_data.get('title')
                if title and 'extract' in page_data:
                    results[title] = page_data['extract']
        return results


# ============================================================================
# CRAWLER DE CATEGORIAS
# ============================================================================

class CategoryCrawler:
    """Crawler para explorar categorias em profundidade"""

    def __init__(
        self,
        api_client: WikiApiClient,
        include_keywords: Optional[List[str]] = None,
        exclude_keywords: Optional[List[str]] = None
    ):
        self.api_client = api_client
        self.include_keywords = [kw.lower() for kw in (include_keywords or [])]
        self.exclude_keywords = [kw.lower() for kw in (exclude_keywords or [])]
        self.visited_categories: Set[str] = set()

    def _should_include_category(self, category_name: str) -> bool:
        category_lower = category_name.lower()
        for exclude_kw in self.exclude_keywords:
            if exclude_kw in category_lower:
                return False
        return True

    def _should_include_page(self, page_title: str) -> bool:
        page_lower = page_title.lower()
        for exclude_kw in self.exclude_keywords:
            if exclude_kw in page_lower:
                return False
        return True

    def crawl(
        self,
        start_category: str,
        max_depth: int,
        max_pages: Optional[int] = None
    ) -> List[str]:
        queue = deque([(start_category, 0)])
        visited_cats = set()
        collected_pages = []

        logger.info(f"Iniciando crawler em '{start_category}' (profundidade: {max_depth})")
        pbar = tqdm(desc="Explorando categorias", unit=" categorias")

        while queue and (max_pages is None or len(collected_pages) < max_pages):
            category, depth = queue.popleft()

            if category in visited_cats or depth > max_depth:
                continue

            visited_cats.add(category)
            pbar.update(1)

            members = self.api_client.get_category_members(category, limit=1000)

            for member in members:
                if max_pages and len(collected_pages) >= max_pages:
                    break

                if member.startswith('Category:'):
                    sub_category = member.replace('Category:', '')
                    if sub_category not in visited_cats and self._should_include_category(sub_category):
                        queue.append((sub_category, depth + 1))
                else:
                    if self._should_include_page(member):
                        collected_pages.append(member)

        pbar.close()
        logger.info(
            f"Crawl completo: {len(collected_pages)} páginas coletadas "
            f"({len(visited_cats)} categorias visitadas)"
        )
        return collected_pages


# ============================================================================
# EXPORTADOR PRINCIPAL
# ============================================================================

class WiktionaryExporter:
    """Exportador principal"""

    def __init__(self):
        self.api_client = WikiApiClient()

    def export(
        self,
        category: str,
        section: str,
        max_depth: int = 2,
        max_pages: Optional[int] = None,
        include_keywords: Optional[List[str]] = None,
        exclude_keywords: Optional[List[str]] = None,
        language: Optional[str] = None
    ):
        # Tracking por categoria: cria (ou carrega) o arquivo certo pra essa exportação
        tracking = TrackingManager(category)

        if language is None and category.lower().endswith(" language"):
            inferred_language = category[:-len(" language")].strip()
            if inferred_language:
                language = inferred_language
                logger.info(f"Idioma inferido automaticamente a partir da categoria: {language}")

        final_include_keywords = Config.DEFAULT_INCLUDE_KEYWORDS.copy()
        if include_keywords:
            final_include_keywords.extend(include_keywords)

        logger.info("=" * 80)
        logger.info("INICIANDO EXPORTAÇÃO WIKTIONARY")
        logger.info(f"Categoria: {category}")
        logger.info(f"Seção: {section if section else 'Artigo Completo (todas as seções)'}")
        if language:
            logger.info(f"Idioma: {language}")
        logger.info(f"Profundidade: {max_depth}")
        logger.info(f"Máximo de páginas: {max_pages or 'ilimitado'}")
        logger.info(f"Inclusões padrão (priorizadas): {', '.join(Config.DEFAULT_INCLUDE_KEYWORDS)}")
        if include_keywords:
            logger.info(f"Inclusões adicionais: {', '.join(include_keywords)}")
        if exclude_keywords:
            logger.info(f"Exclusões: {', '.join(exclude_keywords)}")
        logger.info("=" * 80)

        crawler = CategoryCrawler(
            self.api_client,
            include_keywords=final_include_keywords,
            exclude_keywords=exclude_keywords
        )

        pages = crawler.crawl(category, max_depth, max_pages)
        logger.info(f"Total de páginas para processar: {len(pages)}")

        pages_to_export = [p for p in pages if not tracking.is_exported(p)]

        logger.info(f"Páginas já exportadas (skip): {len(pages) - len(pages_to_export)}")
        logger.info(f"Páginas a exportar: {len(pages_to_export)}")

        if not pages_to_export:
            logger.warning("Nenhuma página nova para exportar!")
            return

        output = OutputManager(category, section)

        stats = {
            'total_pages': len(pages_to_export),
            'exported_pages': 0,
            'failed_pages': 0,
            'empty_sections': 0
        }

        def fetch_page(page_title: str) -> Tuple[str, Optional[str], Optional[str]]:
            """Busca conteúdo + templates de uma página. Roda em thread paralela.
            Retorna (título, conteúdo_final_ou_None, erro_ou_None). Não escreve nada
            em disco aqui — só faz o trabalho de rede, que é o que vale a pena paralelizar.
            """
            try:
                content = self.api_client.get_page_section(page_title, section, language)
                if not content:
                    return page_title, None, None

                if Config.EXPORT_TEMPLATE_SOURCES:
                    template_sources = self.api_client.get_template_sources(content)
                    if template_sources:
                        content = (
                            content
                            + "\n\n" + "=" * 80 + "\n"
                            + "TEMPLATE SOURCES\n"
                            + "=" * 80
                            + template_sources
                        )
                return page_title, content, None
            except Exception as e:
                return page_title, None, str(e)

        pbar = tqdm(total=len(pages_to_export), desc="Exportando páginas", unit=" página")

        with ThreadPoolExecutor(max_workers=Config.MAX_WORKERS) as executor:
            futures = {executor.submit(fetch_page, title): title for title in pages_to_export}

            for future in as_completed(futures):
                page_title, content, error = future.result()

                if error is not None:
                    stats['failed_pages'] += 1
                    logger.error(f"Erro ao processar '{page_title}': {error}")
                elif content is None:
                    stats['empty_sections'] += 1
                    if section:
                        msg = f"Seção '{section}'"
                        if language:
                            msg += f" em {language}"
                        logger.warning(f"{msg} não encontrada em: {page_title}")
                    else:
                        logger.warning(f"Artigo vazio ou sem conteúdo: {page_title}")
                else:
                    # Escrita em arquivo acontece só aqui, no thread principal —
                    # OutputManager não é thread-safe, então isso tem que ficar serializado.
                    output.write_article(page_title, content)
                    tracking.mark_exported(page_title)
                    stats['exported_pages'] += 1
                    if stats['exported_pages'] % 25 == 0:
                        tracking.save_tracking()

                pbar.update(1)
                pbar.set_postfix({
                    'exported': stats['exported_pages'],
                    'failed': stats['failed_pages'],
                    'empty': stats['empty_sections']
                })

        pbar.close()
        output.close()
        tracking.save_tracking()

        logger.info("=" * 80)
        logger.info("EXPORTAÇÃO CONCLUÍDA")
        logger.info(f"Páginas exportadas: {stats['exported_pages']}")
        logger.info(f"Páginas falhadas: {stats['failed_pages']}")
        logger.info(f"Seções vazias: {stats['empty_sections']}")
        logger.info(f"Total exportado (histórico desta categoria): {tracking.get_exported_count()}")
        logger.info("=" * 80)


# ============================================================================
# INTERFACE INTERATIVA
# ============================================================================

def _print_and_log(msg: str):
    print(msg)
    logger.info(msg)


def get_user_config() -> Dict:
    _print_and_log("=" * 80)
    _print_and_log("WIKTIONARY EXPORTER - MODO INTERATIVO")
    _print_and_log("=" * 80)

    config = {}

    config['category'] = input("\n📂 Digite a categoria inicial (ex: 'English nouns'): ").strip()
    if not config['category']:
        config['category'] = 'English nouns'
        _print_and_log(f"   → Usando padrão: {config['category']}")

    config['section'] = input("\n📄 Digite a seção a extrair (ex: 'Definition', 'Etymology') [vazio=artigo completo]: ").strip()
    if config['section']:
        _print_and_log(f"   → Seção: {config['section']}")
    else:
        config['section'] = None
        _print_and_log("   → Exportando artigo completo (todas as seções)")

    config['language'] = input("\n🌐 Digite o idioma para filtrar (ex: 'English', 'Portuguese') [vazio=todos]: ").strip()
    if config['language']:
        _print_and_log(f"   → Filtrando por idioma: {config['language']}")
    else:
        config['language'] = None
        _print_and_log("   → Sem filtro de idioma (todos os idiomas)")

    while True:
        try:
            depth = input("\n⬇️  Profundidade de exploração [1-5]: ").strip()
            config['max_depth'] = int(depth) if depth else 2
            if 1 <= config['max_depth'] <= 5:
                _print_and_log(f"   → Profundidade: {config['max_depth']}")
                break
        except ValueError:
            pass
        print("   ❌ Digite um número entre 1 e 5")

    while True:
        try:
            max_p = input("\n🔢 Máximo de páginas [vazio=ilimitado]: ").strip()
            config['max_pages'] = int(max_p) if max_p else None
            _print_and_log(f"   → Máximo: {config['max_pages']} páginas" if config['max_pages'] else "   → Sem limite de páginas")
            break
        except ValueError:
            print("   ❌ Digite um número válido ou deixe vazio")

    include = input("\n✅ Palavras-chave ADICIONAIS para INCLUIR (separadas por vírgula) [vazio=apenas padrões]: ").strip()
    user_include = [kw.strip() for kw in include.split(',')] if include else []
    config['include_keywords'] = Config.DEFAULT_INCLUDE_KEYWORDS + user_include
    _print_and_log(f"   → Priorizando padrão: {', '.join(Config.DEFAULT_INCLUDE_KEYWORDS)}")
    if user_include:
        _print_and_log(f"   → Priorizando adicional: {', '.join(user_include)}")

    exclude = input("\n❌ Palavras-chave para EXCLUIR (separadas por vírgula) [vazio=nenhuma]: ").strip()
    config['exclude_keywords'] = [kw.strip() for kw in exclude.split(',')] if exclude else None
    if config['exclude_keywords']:
        _print_and_log(f"   → Excluindo: {', '.join(config['exclude_keywords'])}")

    _print_and_log("=" * 80)
    return config


def main():
    try:
        config = get_user_config()
        exporter = WiktionaryExporter()
        exporter.export(
            category=config['category'],
            section=config['section'],
            max_depth=config['max_depth'],
            max_pages=config['max_pages'],
            include_keywords=config['include_keywords'],
            exclude_keywords=config['exclude_keywords'],
            language=config['language']
        )
        _print_and_log("✅ Exportação finalizada com sucesso!")

    except KeyboardInterrupt:
        _print_and_log("⚠️  Exportação cancelada pelo usuário")
    except Exception as e:
        print(f"\n❌ Erro fatal: {e}")
        logger.exception("Erro fatal na exportação")
        raise


if __name__ == '__main__':
    main()