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
    "Category:Statistics",
]

MAX_CATEGORY_DEPTH = 5

CATEGORY_KEYWORDS = {
    # Lógica
    # "logic", "logical", "formal", "proof", "model", "theorem", "informal",
    # "computability", "decidability", "completeness", "consistency",
    # "set theory", "type theory", "boolean", "syntax", "semantics", "axiom"

    # Matemática
    # "mathematics", "math", "algebra", "linear algebra", "group theory",
    # "ring theory", "field theory", "geometry", "topology", "analysis", "trigonometry", "arithmetic",
    # "real analysis", "complex analysis", "calculus", "differential",
    # "integral", "derivative", "limit", "number theory", "combinatorics", "probability", 
    # "measure theory", "functional analysis", "matrix",
    # "vector", "tensor", "set theory", "graph theory",
    # "theorem", "proof", "metric", "category theory"

    # Estatística
    "statistics", "statistical", "statistic", "data", "probability",
    "mean", "median", "mode", "variance", "standard deviation"

    # Ciência da Computação
    # "computer science", "computing", "algorithm", "data structure", "programming", 
    # "software", "hardware", "internet", "web",
    # "network", "database", "artificial intelligence", "machine learning", "deep learning", "neural network", 
    # "computer graphics", "operating system", "compiler", "interpreter", "programming language", "cryptography",
    # "cloud computing", "distributed systems", "parallel computing", "computer architecture", "computer vision",
    # "cybersecurity", "information theory", "data science", "game theory", "decision theory", "theorical computer science", "systems science"

    # Física
    # "physics", "physical", "quantum", "relativity", "thermodynamics", "mechanics", "theory", "theorical physics", 
    # "applied physics", "condensed matter", "particle physics", "nuclear physics",
    # "electromagnetism", "optics", "nuclear", "particle", "astrophysics", "cosmology",

    # Química
    # "chemistry", "chemical", "organic chemistry", "inorganic chemistry", "physical chemistry", "analytical chemistry", 
    # "biochemistry", "materials science", "nanotechnology", "pharmacology", "toxicology", "environmental chemistry", 
    # "theoretical chemistry", "computational chemistry", "chemical engineering"

    # Astronomia
    # "astronomy", "astrophysics", "cosmology", "galaxy", "star", "planet", "black hole", 
    # "universe", "space", "celestial", "exoplanet", "supernova", "nebula", "cosmic", "dark matter", "dark energy", 
    # "gravitational", "radiation", "telescope", "relativity", "quantum", "theory", "observatory"
    
    # Ciências da Terra
    # "geology", "geophysics", "geoscience", "meteorology", "oceanography", "climatology", "seismology", 
    # "volcanology", "paleontology", "geomorphology", "hydrology", "glaciology", "soil science"

    # Biologia
    # "biology", "biological", "life", "organism", "cell", "genetics", "evolution", 
    # "ecology", "microbiology", "zoology", "botany", "physiology", "anatomy", "biochemistry", 
    # "molecular biology", "neuroscience", "immunology", "developmental biology"

    # História
    # "history", "historical", "ancient", "medieval", "modern", "contemporary", "war", "empire", "civilization", "revolution", "dynasty", "colonialism",
    # "renaissance", "enlightenment", "industrial", "post-industrial", "world war", "cold war"
}

# Termos que, se presentes no título da categoria, fazem o script descartar o ramo inteiro
EXCLUDE_KEYWORDS = {
    "fauna", "flora", "animals", "species", "biology", "evolution",
    # "biography", "biographies", "people", "births", "deaths",
    "logicians", "philosophers", "astronomers", "chemists", "biologists", "military history", "economic history",
    "mathematicians", "theorists", "historians", "educators", "women", "country", "physicists", "psychologists", "algebraists", "statisticians", "geneticists",
    "analysts", "economists", "fiction", "society", "information", 
    # "computer", "computational", "software", 
    "fictional", "pathologists", "ecologists", "geometers",
    "movements", "scientists", "engineers", "culture", "media", "films", "television", "games", "novels", "books", "documentary", "academic", "biology in", "botany in", 
    "by country", "by century", "by decade", "by year", "by region", "by state", "by war", "by strait", "by occupation", "by conflict", "by company", "by language", "by profession", "by field", "by discipline", "by subject", "by topic", "by theme", "by genre",
    "by sea", "by island", "by body of water", "by mountain range", "people", "by city", "by location", "by university", "by institution", "by organization", "by continent", "by dependent territory",
    "works", "physicians", "astronomers", "universities", "organizations", "literature", "journals", "publications", "awards", "education", "institutions", "competitions", "research", "discoveries", "inventions", "inventions and discoveries", "inventions and innovations", 
    "inventions and patents", "inventions and discoveries in", "inventions and innovations in", "ethics",
    "conferences", "events", "wikipedia", "stubs", "templates", "lists of", "companies", "pioneers", "founders", "inventors", "discoverers", "explorers", "researchers", "professionals", "developed in",
    "authors", "writers", "poets", "composers", "artists", "musicians", "law", "criticism", "regulations", "regulation", "legislation", "legal", "judicial", "political", "governmental", "administrative", "constitutional", "international law", "deaths"
    "-related lists", 
    "algebra", "arithmetic", "geometry", "geometric", "geometrical", "calculus", 
    # "analysis", "analytical", "analyses",
    # "history of", "internet in", "statistics of", "statistical regions", "statistical areas", "distribution", "database", "databases", "data", "records and statistics", "crime", "economics", "medical"
    "categories with", "articles with", "pages with", "articles needing", "articles lacking", "articles containing", "pages", "images", "screenshots", "services", "providers", "open-source", "open source", "closed-source", "closed source", "proprietary", "freeware", 
    "shareware", "software packages", "software applications", "software programs", "software tools", "software libraries", "software frameworks", "hardware", "software",
    "articles about", "articles in", "articles with", "articles missing", "articles needing", "articles lacking", "articles containing", "Linux", "Microsoft", "Windows", "iOS", "Android", "Apple", 
    "Google", "Amazon", "Facebook", "Twitter", "X", "Instagram", "Snapchat", "TikTok", "YouTube", "Reddit", "WhatsApp", "Telegram", "Signal", "Discord", "creation date"
}

REQUEST_DELAY = 0.3
visited_categories = set()
visited_pages = set()
OUTPUT_DIR = r"C:\Users\heito\Downloads\Notebook Supremo\Ciências Formais"

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
    export_pages_segmented("Estatística.txt", word_limit=500000)

if __name__ == "__main__":
    main()