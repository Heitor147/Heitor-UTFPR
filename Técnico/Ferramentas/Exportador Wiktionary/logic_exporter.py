#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Wikipedia Logic Exporter (TXT Version)
Exporta artigos relacionados à lógica formal da Wikipedia EN para um arquivo .txt
"""

import requests
import time
from tqdm import tqdm
from collections import deque

API = "https://en.wikipedia.org/w/api.php"

ROOT_CATEGORIES = [
    "Category:Logic-related lists",
]

MAX_CATEGORY_DEPTH = 0

CATEGORY_KEYWORDS = {
    "logic",
}

REQUEST_DELAY = 0.1
visited_categories = set()
visited_pages = set()

# Identifique-se corretamente para a API da Wikimedia
HEADERS = {
    "User-Agent": "LogicExporter/1.0 (heitorhenriqur523@gmail.com)"
}

def is_relevant_category(title: str) -> bool:
    title_lower = title.lower()
    return any(kw in title_lower for kw in CATEGORY_KEYWORDS)

def api_get(params):
    while True:
        try:
            response = requests.get(API, params=params, headers=HEADERS, timeout=30)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            print(f"[ERRO] {e}. Tentando novamente...")
            time.sleep(2)

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

def export_pages_to_txt(output_file):
    titles = list(visited_pages)
    batch_size = 50
    print(f"\n[INFO] Total de artigos encontrados: {len(titles)}")

    with open(output_file, "w", encoding="utf-8") as f:
        for i in tqdm(range(0, len(titles), batch_size)):
            batch = titles[i:i + batch_size]
            params = {
                "action": "query",
                "prop": "revisions",
                "rvprop": "content",
                "rvslots": "main",
                "titles": "|".join(batch),
                "formatversion": "2",
                "format": "json",
            }

            data = api_get(params)
            
            for page in data["query"]["pages"]:
                if "missing" in page or "revisions" not in page:
                    continue

                title = page['title']
                content = page['revisions'][0]['slots']['main']['content']

                # Formatação simples para o TXT
                f.write(f"{'='*80}\n")
                f.write(f"TITLE: {title}\n")
                f.write(f"{'='*80}\n\n")
                f.write(content)
                f.write("\n\n") # Espaço entre artigos

            time.sleep(REQUEST_DELAY)

    print(f"\n[OK] Arquivo TXT salvo em: {output_file}")

def main():
    print("=" * 60)
    print("WIKIPEDIA LOGIC EXPORTER (TXT)")
    print("=" * 60)
    crawl_categories()
    export_pages_to_txt("ListasLógica.txt")

if __name__ == "__main__":
    main()