#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Wikipedia Topic Exporter (TXT Version)
Exporta artigos relacionados à tópicos especificos da Wikipedia EN para um arquivo .txt
"""

import requests
import time
import urllib3
from tqdm import tqdm
from collections import deque
import os
import re

API = "https://en.wikipedia.org/w/api.php"

ROOT_CATEGORIES = [
    "Category:Chemistry",
]

MAX_CATEGORY_DEPTH = 5

CATEGORY_KEYWORDS = {
    # Lógica
    # "logic", "logical", "formal", "proof", "model", "theorem",
    # "computability", "decidability", "completeness", "consistency",
    # "set theory", "type theory", "boolean", "syntax", "semantics", "axiom"

    # Matemática
    # "mathematics", "math", "algebra", "linear algebra", "group theory",
    # "ring theory", "field theory", "geometry", "topology", "analysis",
    # "real analysis", "complex analysis", "calculus", "differential",
    # "integral", "number theory", "combinatorics", "probability", 
    # "measure theory", "functional analysis", "matrix",
    # "vector", "tensor", "set theory", "graph theory",
    # "theorem", "proof", "metric", "category theory"

    # Estatística
    # "statistics", "statistical", "statistic", "data", "probability",
    # "mean", "median", "mode", "variance", "standard deviation"

    # Física
    # "physics", "physical", "quantum", "relativity", "thermodynamics", "mechanics", "theory", "theorical physics", 
    # "applied physics", "condensed matter", "particle physics", "nuclear physics",
    # "electromagnetism", "optics", "nuclear", "particle", "astrophysics", "cosmology",

    # Química
    "chemistry", "chemical", "organic chemistry", "inorganic chemistry", "physical chemistry", "analytical chemistry", 
    "biochemistry", "materials science", "nanotechnology", "pharmacology", "toxicology", "environmental chemistry", 
    "theoretical chemistry", "computational chemistry", "chemical engineering"
}

# Termos que, se presentes no título da categoria, fazem o script descartar o ramo inteiro
EXCLUDE_KEYWORDS = {
    # "fauna", "flora", "animals", "species", "biology", "evolution",
    "biography", "biographies", "people", "births", "deaths", "history of", "logicians", "philosophers", "astronomers", "chemists",
    "mathematicians", "theorists", "historians", "educators", "women", "country", "physicists", "psychologists", "algebraists", "statisticians", "geneticists",
    "analysts", "economists", "fiction", "society", "information", "computer", "computational", "logic", "software", "fictional", "pathologists", "ecologists",
    "movements", "scientists", "engineers", "culture", "media", "films", "television", "games", "novels", "books", "documentary", "academic", 
    "works", "physicians","universities", "organizations", "journals", "publications", "awards", "education", "institutions", "conferences", "events", "wikipedia", "stubs", "templates", "lists of", 
    "-related lists", "statistics of", "statistical regions", "statistical areas", "distribution", "database", "databases", "data", "records and statistics", "crime", "economics", "medical"
    "categories with", "articles with", "pages with", "articles needing", "articles lacking", "articles containing", 
    "articles about", "articles in", "articles with", "articles missing", "articles needing", "articles lacking", "articles containing"
}

REQUEST_DELAY = 0.3
visited_categories = set()
visited_pages = set()
OUTPUT_DIR = r"C:\Users\heito\Downloads\NotebookSupremo — Ordem Natural"

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Identifique-se corretamente para a API da Wikimedia
HEADERS = {
    "User-Agent": "LogicExporter/1.0 (heitorhenriqur523@gmail.com)"
}

def is_relevant_category(title: str) -> bool:
    title_lower = title.lower()
    
    # 1º Filtro: Se tiver qualquer palavra de exclusão, ignora na hora
    if any(exclude_kw in title_lower for exclude_kw in EXCLUDE_KEYWORDS):
        return False
        
    # 2º Filtro: Se passou pelo primeiro, checa se tem as palavras-chave de lógica
    return any(kw in title_lower for kw in CATEGORY_KEYWORDS)

def api_get(params):
    while True:
        try:
            response = requests.get(API, params=params, headers=HEADERS, timeout=60, verify=False)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            print(f"[ERRO] {e}")
            print("Servidor ocupado ou timeout atingido. Aguardando 5 segundos para tentar novamente...")
            time.sleep(5)

def get_category_members(category):
    members = []
    cmcontinue = None
    while True:
        params = {
            "action": "query",
            "list": "categorymembers",
            "cmtitle": category,
            "cmlimit": "max",
            "cmtype": "page|subcat",
            "format": "json",
        }
        if cmcontinue:
            params["cmcontinue"] = cmcontinue
        data = api_get(params)
        members.extend(data["query"]["categorymembers"])
        if "continue" not in data:
            break
        cmcontinue = data["continue"]["cmcontinue"]
        time.sleep(REQUEST_DELAY)
    return members

def crawl_categories():
    queue = deque()
    for category in ROOT_CATEGORIES:
        queue.append((category, 0))

    while queue:
        category, depth = queue.popleft()
        if category in visited_categories or depth > MAX_CATEGORY_DEPTH:
            continue
        
        visited_categories.add(category)
        print(f"[CATEGORIA] {category} | profundidade={depth}")

        try:
            members = get_category_members(category)
        except Exception as e:
            print(f"[ERRO CATEGORIA] {category}: {e}")
            continue

        for member in members:
            title = member["title"]
            ns = member["ns"]
            if ns == 14: # Categoria
                if is_relevant_category(title):
                    queue.append((title, depth + 1))
            elif ns == 0: # Artigo
                visited_pages.add(title)
        time.sleep(REQUEST_DELAY)

def load_already_exported_titles(base_filename):
    """Carrega títulos de artigos já exportados dos arquivos existentes."""
    already_exported = set()
    name, ext = os.path.splitext(base_filename)
    
    if not os.path.exists(OUTPUT_DIR):
        return already_exported
    
    # Procura por todos os arquivos de partes já exportadas
    for filename in os.listdir(OUTPUT_DIR):
        if filename.startswith(name) and filename.endswith(ext):
            filepath = os.path.join(OUTPUT_DIR, filename)
            try:
                with open(filepath, "r", encoding="utf-8") as f:
                    content = f.read()
                    # Extrai os títulos usando o padrão "TITLE: {titulo}"
                    titles = re.findall(r"TITLE: (.+?)\n", content)
                    already_exported.update(titles)
            except Exception as e:
                print(f"[AVISO] Erro ao ler {filename}: {e}")
    
    return already_exported

def export_pages_segmented(base_filename, word_limit=500000):
    titles = list(visited_pages)
    batch_size = 50
    
    current_part = 1
    current_word_count = 0
    
    # Função auxiliar para gerar nome do arquivo
    def get_filename(part):
        name, ext = os.path.splitext(base_filename)
        return os.path.join(OUTPUT_DIR, f"{name}_part{part}{ext}")

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Carrega títulos já exportados
    already_exported = load_already_exported_titles(base_filename)
    if already_exported:
        print(f"\n[INFO] {len(already_exported)} artigos já foram exportados. Pulando...")
        titles = [t for t in titles if t not in already_exported]
        print(f"[INFO] {len(titles)} artigos restantes para exportar.")
    
    if not titles:
        print("[OK] Todos os artigos já foram exportados!")
        return

    f = open(get_filename(current_part), "w", encoding="utf-8")
    print(f"\n[INFO] Iniciando exportação. Limite: {word_limit} palavras por arquivo.")

    for i in tqdm(range(0, len(titles), batch_size)):
        batch = titles[i:i + batch_size]
        params = {
            "action": "query", "prop": "revisions", "rvprop": "content",
            "rvslots": "main", "titles": "|".join(batch), "formatversion": "2", "format": "json"
        }

        data = api_get(params)
        
        for page in data["query"]["pages"]:
            if "missing" in page or "revisions" not in page: continue

            title = page['title']
            content = page['revisions'][0]['slots']['main']['content']
            
            # Conta palavras do artigo atual (separando por espaços)
            words_in_article = len(content.split())

            # Verifica se adicionar este artigo estoura o limite do arquivo atual
            if current_word_count + words_in_article > word_limit and current_word_count > 0:
                f.close()
                print(f"\n[AVISO] Limite atingido no arquivo {current_part}. Criando parte {current_part + 1}...")
                current_part += 1
                current_word_count = 0
                f = open(get_filename(current_part), "w", encoding="utf-8")

            # Escreve no arquivo (seja o original ou a nova parte)
            f.write(f"{'='*80}\nTITLE: {title}\n{'='*80}\n\n{content}\n\n")
            current_word_count += words_in_article

        time.sleep(REQUEST_DELAY)

    f.close()
    print(f"\n[OK] Exportação finalizada em {current_part} arquivos.")

def main():
    print("=" * 60)
    print("WIKIPEDIA TOPIC EXPORTER (TXT)")
    print("=" * 60)
    crawl_categories()
    export_pages_segmented("Química.txt", word_limit=500000)

if __name__ == "__main__":
    main()