#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Wiktionary Mass Exporter - Production Version
Exporta artigos da Wiktionary em larga escala com suporte a categorias, filtros e controle de profundidade.
"""

import os
import json
import time
import hashlib
import logging
from pathlib import Path
from typing import Set, List, Dict, Optional, Tuple
from collections import deque
from datetime import datetime

import requests
from tqdm import tqdm

# ============================================================================
# CONFIGURAÇÃO
# ============================================================================

class Config:
    """Configuração centralizada da aplicação"""
    
    # API e requisições
    WIKTIONARY_API_URL = "https://en.wiktionary.org/w/api.php"
    USER_AGENT = "WiktionaryExporter/1.0 (+https://github.com/yourusername/wiktionary-exporter)"
    REQUEST_TIMEOUT = 30
    REQUEST_DELAY = 1.0  # segundos entre requisições
    MAX_BATCH_SIZE = 50  # máximo de páginas por requisição em lotes
    MAX_RETRIES = 3
    RETRY_DELAY = 5.0
    
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
    EXPORT_TIMESTAMP = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Tracking
    TRACKING_DIR = "wiktionary_tracking"
    TRACKING_FILE = f"exported_{EXPORT_TIMESTAMP}.json"
    
    # Logging
    LOG_DIR = "logs"
    LOG_FILE = f"wiktionary_export_{EXPORT_TIMESTAMP}.log"
    
    @classmethod
    def ensure_directories(cls):
        """Cria diretórios necessários"""
        Path(cls.OUTPUT_DIR).mkdir(exist_ok=True)
        Path(cls.TRACKING_DIR).mkdir(exist_ok=True)
        Path(cls.LOG_DIR).mkdir(exist_ok=True)


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
            logging.FileHandler(log_path),
            logging.StreamHandler()
        ]
    )
    
    return logging.getLogger(__name__)


logger = setup_logging()


# ============================================================================
# GERENCIADOR DE TRACKING
# ============================================================================

class TrackingManager:
    """Gerencia quais artigos já foram exportados"""
    
    def __init__(self):
        Config.ensure_directories()
        self.tracking_file = os.path.join(Config.TRACKING_DIR, Config.TRACKING_FILE)
        self.exported_pages: Set[str] = set()
        self.load_tracking()
    
    def load_tracking(self):
        """Carrega lista de páginas já exportadas"""
        if os.path.exists(self.tracking_file):
            try:
                with open(self.tracking_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    self.exported_pages = set(data.get('exported_pages', []))
                    logger.info(f"Carregadas {len(self.exported_pages)} páginas já exportadas")
            except Exception as e:
                logger.warning(f"Erro ao carregar tracking: {e}")
    
    def save_tracking(self):
        """Salva lista de páginas exportadas"""
        try:
            with open(self.tracking_file, 'w', encoding='utf-8') as f:
                json.dump({
                    'exported_pages': sorted(list(self.exported_pages)),
                    'timestamp': datetime.now().isoformat(),
                    'total': len(self.exported_pages)
                }, f, ensure_ascii=False, indent=2)
        except Exception as e:
            logger.error(f"Erro ao salvar tracking: {e}")
    
    def is_exported(self, page_title: str) -> bool:
        """Verifica se página já foi exportada"""
        return page_title in self.exported_pages
    
    def mark_exported(self, page_title: str):
        """Marca página como exportada"""
        self.exported_pages.add(page_title)
    
    def get_exported_count(self) -> int:
        """Retorna número de páginas exportadas"""
        return len(self.exported_pages)


# ============================================================================
# GERENCIADOR DE ARQUIVOS DE SAÍDA
# ============================================================================

class OutputManager:
    """Gerencia escrita em arquivos com split automático"""
    
    def __init__(self, category_name: str, section: Optional[str]):
        Config.ensure_directories()
        self.category_name = category_name.replace(" ", "_").replace("/", "_")
        self.section = section.replace(" ", "_") if section else "full_article"
        self.current_file_num = 1
        self.current_word_count = 0
        self.current_file = None
        self.active = False
        self._open_new_file()
    
    def _open_new_file(self):
        """Abre novo arquivo de saída"""
        if self.current_file is not None:
            self.current_file.close()
        
        filename = f"{self.category_name}_{self.section}_part{self.current_file_num}.txt"
        filepath = os.path.join(Config.OUTPUT_DIR, filename)
        
        self.current_file = open(filepath, 'a', encoding='utf-8')
        self.active = True
        logger.info(f"Arquivo aberto: {filename}")
    
    def write_article(self, title: str, content: str):
        """Escreve artigo no arquivo, faz split se necessário"""
        word_count = len(content.split())
        
        # Se adicionar este artigo ultrapassaria o limite, cria novo arquivo
        if self.current_word_count + word_count > Config.MAX_WORDS_PER_FILE:
            self.current_file_num += 1
            self.current_word_count = 0
            self._open_new_file()
        
        # Escreve cabeçalho e conteúdo
        self.current_file.write(f"\n{'='*80}\n")
        self.current_file.write(f"TITLE: {title}\n")
        self.current_file.write(f"EXTRACTED: {datetime.now().isoformat()}\n")
        self.current_file.write(f"{'='*80}\n\n")
        self.current_file.write(content)
        self.current_file.write(f"\n\n")
        
        self.current_word_count += word_count
        self.current_file.flush()
    
    def close(self):
        """Fecha arquivo atual"""
        if self.current_file:
            self.current_file.close()
            self.active = False
            logger.info(f"Arquivo fechado (total de palavras: {self.current_word_count})")


# ============================================================================
# CLIENT DA API WIKTIONARY
# ============================================================================

class WikiApiClient:
    """Cliente para requisições à API MediaWiki (Wiktionary)"""
    
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({'User-Agent': Config.USER_AGENT})
        self.last_request_time = 0
    
    def _throttle(self):
        """Implementa delay entre requisições"""
        elapsed = time.time() - self.last_request_time
        if elapsed < Config.REQUEST_DELAY:
            time.sleep(Config.REQUEST_DELAY - elapsed)
        self.last_request_time = time.time()
    
    def _request_with_retry(self, params: Dict) -> Optional[Dict]:
        """Faz requisição com retry automático"""
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
                if ns == 0 and ':' in title:
                    # Segurança extra: evita namespaces como Wiktionary:, Help:, Appendix:, Template:
                    continue
                members.append(title)
                pbar.update(1)
            
            # Verifica se há mais páginas
            if 'continue' not in data:
                break
            
            continue_token = data['continue'].get('cmcontinue')
        
        pbar.close()
        return members[:limit]
    
    def get_page_content(self, title: str) -> Optional[str]:
        """Obtém conteúdo completo bruto (wikitext) de uma página"""
        return self._get_raw_wikitext(title)

    def _get_raw_wikitext(self, title: str) -> Optional[str]:
        """Busca o wikitext completo da página via API"""
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
        """Extrai nomes de templates usados no wikitext."""
        import re

        names = []
        seen = set()
        for match in re.finditer(r'\{\{\s*([^\{\}\|\n]+)', wikitext):
            name = match.group(1).strip()
            if not name:
                continue
            if name.startswith('#'):
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
        """Retorna o wikitext bruto das templates referenciadas no texto."""
        limit = max_templates or Config.MAX_TEMPLATE_SOURCES_PER_PAGE
        template_names = self._extract_template_names(wikitext)[:limit]
        blocks = []

        for template_name in template_names:
            template_title = f"Template:{template_name}"
            template_text = self._get_raw_wikitext(template_title)
            if not template_text:
                continue
            blocks.append(
                f"\n\n--- TEMPLATE SOURCE: {template_title} ---\n"
                f"{template_text.strip()}\n"
            )

        return ''.join(blocks)
    
    def get_page_section(self, title: str, section: Optional[str] = None, language: Optional[str] = None) -> Optional[str]:
        """Obtém seção específica de uma página, opcionalmente filtrada por idioma
        
        Args:
            title: Título da página
            section: Nome da seção (ex: Definition, Etymology) - None = artigo completo
            language: Idioma específico (ex: English, Portuguese) - opcional
        """
        
        raw = self._get_raw_wikitext(title)
        if not raw:
            return None

        import re

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

        # Artigo completo: retorna bloco do idioma ou o wikitext bruto
        if section_pattern is None:
            if language_pattern:
                lang_start, lang_end = find_language_block(language_pattern)
                if lang_start is None:
                    return None
                return '\n'.join(lines[lang_start:lang_end]).strip() or None
            return raw.strip() or None

        # Se idioma foi informado, restringe a busca ao bloco daquele idioma
        search_start = 0
        search_end = len(lines)
        if language_pattern:
            lang_start, lang_end = find_language_block(language_pattern)
            if lang_start is None:
                return None
            search_start = lang_start
            search_end = lang_end

        # Encontra a seção desejada dentro do intervalo definido
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
        """Obtém múltiplas páginas em batch"""
        results = {}
        
        # Processa em chunks respeitando MAXBATCHSIZEs
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
        """Verifica se categoria deve ser explorada baseado em palavras-chave
        
        As include_keywords PRIORIZAM categorias mas não descartam outras
        As exclude_keywords DESCARTAM categorias
        """
        category_lower = category_name.lower()
        
        # Se tem palavras de exclusão, descarta a categoria
        for exclude_kw in self.exclude_keywords:
            if exclude_kw in category_lower:
                return False
        
        # Incluir a categoria (as include_keywords só priorizam, não descartam)
        return True
    
    def _should_include_page(self, page_title: str) -> bool:
        """Verifica se página deve ser coletada baseado em palavras-chave
        
        As include_keywords NÃO filtram páginas (apenas priorizam categorias)
        As exclude_keywords DESCARTAM páginas
        """
        page_lower = page_title.lower()
        
        # Se tem palavras de exclusão, descarta a página
        for exclude_kw in self.exclude_keywords:
            if exclude_kw in page_lower:
                return False
        
        # Páginas não são filtradas por include_keywords, apenas coletadas
        return True
    
    def crawl(
        self,
        start_category: str,
        max_depth: int,
        max_pages: Optional[int] = None
    ) -> List[str]:
        """
        Faz crawl de categorias explorando em profundidade
        
        Args:
            start_category: Categoria inicial
            max_depth: Profundidade máxima
            max_pages: Máximo de páginas a extrair (None = ilimitado)
        
        Returns:
            Lista de títulos de páginas
        """
        queue = deque([(start_category, 0)])  # (categoria, profundidade)
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
            
            # Obtém membros da categoria
            members = self.api_client.get_category_members(category, limit=1000)
            
            for member in members:
                if max_pages and len(collected_pages) >= max_pages:
                    break
                
                # Se é categoria, add à fila para explorar
                if member.startswith('Category:'):
                    sub_category = member.replace('Category:', '')
                    if sub_category not in visited_cats and self._should_include_category(sub_category):
                        queue.append((sub_category, depth + 1))
                # Se é página regular, coleta (respeitando filtros)
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
        self.tracking = TrackingManager()
    
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
        """
        Executa exportação completa
        
        Args:
            category: Categoria inicial
            section: Seção a extrair (ex: "Definition", "Etymology")
            max_depth: Profundidade de exploração
            max_pages: Máximo de páginas
            include_keywords: Palavras-chave prioritárias (merged com defaults)
            exclude_keywords: Palavras-chave de exclusão
            language: Idioma específico para filtrar (ex: "English", "Portuguese") - opcional
        """

        # Se a categoria é uma categoria-mãe de idioma e o idioma não foi informado,
        # tenta inferir automaticamente para ignorar páginas meta como guidelines.
        if language is None and category.lower().endswith(" language"):
            inferred_language = category[:-len(" language")].strip()
            if inferred_language:
                language = inferred_language
                logger.info(f"Idioma inferido automaticamente a partir da categoria: {language}")
        
        # Combina include_keywords com padrões
        final_include_keywords = Config.DEFAULT_INCLUDE_KEYWORDS.copy()
        if include_keywords:
            final_include_keywords.extend(include_keywords)
        
        logger.info("="*80)
        logger.info("INICIANDO EXPORTAÇÃO WIKTIONARY")
        logger.info(f"Categoria: {category}")
        if section:
            logger.info(f"Seção: {section}")
        else:
            logger.info(f"Seção: Artigo Completo (todas as seções)")
        if language:
            logger.info(f"Idioma: {language}")
        logger.info(f"Profundidade: {max_depth}")
        logger.info(f"Máximo de páginas: {max_pages or 'ilimitado'}")
        logger.info(f"Inclusões padrão (priorizadas): {', '.join(Config.DEFAULT_INCLUDE_KEYWORDS)}")
        if include_keywords:
            logger.info(f"Inclusões adicionais: {', '.join(include_keywords)}")
        if exclude_keywords:
            logger.info(f"Exclusões: {', '.join(exclude_keywords)}")
        logger.info("="*80)
        
        # 1. Crawl de categorias
        crawler = CategoryCrawler(
            self.api_client,
            include_keywords=final_include_keywords,
            exclude_keywords=exclude_keywords
        )
        
        pages = crawler.crawl(category, max_depth, max_pages)
        logger.info(f"Total de páginas para processar: {len(pages)}")
        
        # 2. Filtra páginas já exportadas
        pages_to_export = [
            p for p in pages
            if not self.tracking.is_exported(p)
        ]
        
        logger.info(
            f"Páginas já exportadas (skip): {len(pages) - len(pages_to_export)}"
        )
        logger.info(f"Páginas a exportar: {len(pages_to_export)}")
        
        if not pages_to_export:
            logger.warning("Nenhuma página nova para exportar!")
            return
        
        # 3. Exporta páginas
        output = OutputManager(category, section)
        
        stats = {
            'total_pages': len(pages_to_export),
            'exported_pages': 0,
            'failed_pages': 0,
            'empty_sections': 0
        }
        
        pbar = tqdm(pages_to_export, desc="Exportando páginas", unit=" página")
        
        for page_title in pbar:
            try:
                # Obtém seção específica
                content = self.api_client.get_page_section(page_title, section, language)
                
                if not content:
                    stats['empty_sections'] += 1
                    if section:
                        if language:
                            logger.warning(f"Seção '{section}' em {language} não encontrada em: {page_title}")
                        else:
                            logger.warning(f"Seção '{section}' não encontrada em: {page_title}")
                    else:
                        logger.warning(f"Artigo vazio ou sem conteúdo: {page_title}")
                    continue

                # Anexa fontes dos templates usados no texto para ajudar a IA a interpretar o verbete
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
                
                # Escreve no arquivo
                output.write_article(page_title, content)
                
                # Marca como exportado
                self.tracking.mark_exported(page_title)
                stats['exported_pages'] += 1
                
                pbar.set_postfix({
                    'exported': stats['exported_pages'],
                    'failed': stats['failed_pages'],
                    'empty': stats['empty_sections']
                })
                
            except Exception as e:
                stats['failed_pages'] += 1
                logger.error(f"Erro ao processar '{page_title}': {e}")
        
        # 4. Finaliza
        output.close()
        self.tracking.save_tracking()
        
        logger.info("="*80)
        logger.info("EXPORTAÇÃO CONCLUÍDA")
        logger.info(f"Páginas exportadas: {stats['exported_pages']}")
        logger.info(f"Páginas falhadas: {stats['failed_pages']}")
        logger.info(f"Seções vazias: {stats['empty_sections']}")
        logger.info(f"Total exportado anteriormente: {self.tracking.get_exported_count()}")
        logger.info("="*80)


# ============================================================================
# INTERFACE INTERATIVA
# ============================================================================

def get_user_config() -> Dict:
    """Coleta configuração interativa do usuário"""
    print("\n" + "="*80)
    print("WIKTIONARY EXPORTER - MODO INTERATIVO")
    print("="*80 + "\n")
    
    config = {}
    
    # Categoria
    config['category'] = input("📂 Digite a categoria inicial (ex: 'English nouns'): ").strip()
    if not config['category']:
        config['category'] = 'English nouns'
        print(f"   → Usando padrão: {config['category']}")
    
    # Seção
    config['section'] = input("\n📄 Digite a seção a extrair (ex: 'Definition', 'Etymology') [vazio=artigo completo]: ").strip()
    if config['section']:
        print(f"   → Seção: {config['section']}")
    else:
        config['section'] = None
        print(f"   → Exportando artigo completo (todas as seções)")
    
    # Idioma (opcional)
    config['language'] = input("\n🌐 Digite o idioma para filtrar (ex: 'English', 'Portuguese') [vazio=todos]: ").strip()
    if config['language']:
        print(f"   → Filtrando por idioma: {config['language']}")
    else:
        config['language'] = None
        print(f"   → Sem filtro de idioma (todos os idiomas)")
    
    # Profundidade
    while True:
        try:
            depth = input("\n⬇️  Profundidade de exploração [1-5]: ").strip()
            config['max_depth'] = int(depth) if depth else 2
            if 1 <= config['max_depth'] <= 5:
                print(f"   → Profundidade: {config['max_depth']}")
                break
        except ValueError:
            pass
        print("   ❌ Digite um número entre 1 e 5")
    
    # Máximo de páginas
    while True:
        try:
            max_p = input("\n🔢 Máximo de páginas [vazio=ilimitado]: ").strip()
            config['max_pages'] = int(max_p) if max_p else None
            if config['max_pages']:
                print(f"   → Máximo: {config['max_pages']} páginas")
            else:
                print("   → Sem limite de páginas")
            break
        except ValueError:
            print("   ❌ Digite um número válido ou deixe vazio")
    
    # Palavras-chave inclusão
    include = input("\n✅ Palavras-chave ADICIONAIS para INCLUIR (separadas por vírgula) [vazio=apenas padrões]: ").strip()
    user_include = [kw.strip() for kw in include.split(',')] if include else []
    
    # Combina com palavras-chave padrão
    config['include_keywords'] = Config.DEFAULT_INCLUDE_KEYWORDS + user_include
    print(f"   → Priorizando padrão: {', '.join(Config.DEFAULT_INCLUDE_KEYWORDS)}")
    if user_include:
        print(f"   → Priorizando adicional: {', '.join(user_include)}")
    
    # Palavras-chave exclusão
    exclude = input("\n❌ Palavras-chave para EXCLUIR (separadas por vírgula) [vazio=nenhuma]: ").strip()
    config['exclude_keywords'] = [kw.strip() for kw in exclude.split(',')] if exclude else None
    if config['exclude_keywords']:
        print(f"   → Excluindo: {', '.join(config['exclude_keywords'])}")
    
    print("\n" + "="*80)
    
    return config


def main():
    """Função principal"""
    try:
        # Coleta configuração
        config = get_user_config()
        
        # Inicializa exportador
        exporter = WiktionaryExporter()
        
        # Executa exportação
        exporter.export(
            category=config['category'],
            section=config['section'],
            max_depth=config['max_depth'],
            max_pages=config['max_pages'],
            include_keywords=config['include_keywords'],
            exclude_keywords=config['exclude_keywords'],
            language=config['language']
        )
        
        print("\n✅ Exportação finalizada com sucesso!")
        
    except KeyboardInterrupt:
        print("\n\n⚠️  Exportação cancelada pelo usuário")
        logger.info("Exportação cancelada pelo usuário")
    except Exception as e:
        print(f"\n❌ Erro fatal: {e}")
        logger.exception("Erro fatal na exportação")
        raise


if __name__ == '__main__':
    main()
