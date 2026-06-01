# Wiktionary Exporter - Exportador em Larga Escala

Ferramenta profissional para exportar artigos da Wiktionary em escala, com suporte a categorias, filtros avançados e controle de profundidade.

## 🎯 Funcionalidades

- ✅ Exportação de artigos da Wiktionary via API MediaWiki
- ✅ Exploração recursiva de categorias com controle de profundidade
- ✅ Filtros por palavras-chave (inclusão e exclusão)
- ✅ Extração de seções específicas (Definition, Etymology, etc.)
- ✅ Split automático de arquivos em 500.000 palavras
- ✅ Sistema de tracking para evitar reexportação
- ✅ Throttling e retry automático para não sobrecarregar
- ✅ Interface interativa + modo CLI
- ✅ Logging detalhado
- ✅ Otimizado para exportar **centenas de milhares ou milhões de páginas**

## 📦 Instalação

```bash
# Instalar dependências
pip install -r requirements.txt
```

## 🚀 Uso Básico

### Modo Interativo (Simple)

```bash
python wiktionary_exporter.py
```

Será solicitado:
- Categoria inicial
- Seção desejada
- Profundidade
- Máximo de páginas
- Palavras-chave (inclusão/exclusão)

### Modo Script (Para Produção)

```python
from wiktionary_exporter import WiktionaryExporter

exporter = WiktionaryExporter()
exporter.export(
    category='English nouns',
    section='Definition',
    max_depth=3,
    max_pages=100000,
    include_keywords=['animal', 'plant'],
    exclude_keywords=['obsolete', 'archaic']
)
```

## 🔧 Advanced: Exportação em Larga Escala

Para exportar **centenas de milhares ou milhões de páginas**, use o script de produção:

```python
#!/usr/bin/env python3
"""
script_larga_escala.py
Exporta múltiplas categorias em paralelo com checkpoint
"""

import sys
from wiktionary_exporter import WiktionaryExporter, logger

def export_batch(categories_config):
    """
    Exporta múltiplas categorias em sequência com savepoints
    
    Args:
        categories_config: Lista de dicts com configuração de cada export
    """
    exporter = WiktionaryExporter()
    
    for i, config in enumerate(categories_config, 1):
        print(f"\n{'='*80}")
        print(f"BATCH {i}/{len(categories_config)}")
        print(f"{'='*80}\n")
        
        try:
            exporter.export(**config)
        except Exception as e:
            logger.error(f"Erro no batch {i}: {e}")
            # Continua com próximo ao invés de parar tudo
            continue
    
    logger.info("✅ Exportação de todos os batches concluída!")


# EXEMPLO DE CONFIGURAÇÃO PARA MILHÕES DE PÁGINAS
if __name__ == '__main__':
    
    # Definir categorias a exportar
    # Para escala massiva, você pode fazer:
    # 1. Especificar múltiplas categorias base
    # 2. Usar profundidade maior
    # 3. Deixar max_pages como None (ilimitado)
    
    categories = [
        # Nouns
        {
            'category': 'English nouns',
            'section': 'Definition',
            'max_depth': 4,
            'max_pages': None,  # Sem limite
            'exclude_keywords': ['obsolete', 'archaic', 'rare']
        },
        # Verbs
        {
            'category': 'English verbs',
            'section': 'Definition',
            'max_depth': 4,
            'max_pages': None,
            'exclude_keywords': ['obsolete', 'archaic', 'rare']
        },
        # Adjectives
        {
            'category': 'English adjectives',
            'section': 'Definition',
            'max_depth': 4,
            'max_pages': None,
            'exclude_keywords': ['obsolete', 'archaic', 'rare']
        },
        # Com filtro específico
        {
            'category': 'Animals',
            'section': 'Definition',
            'max_depth': 5,
            'max_pages': None,
            'include_keywords': ['animal', 'creature', 'beast'],
            'exclude_keywords': ['extinct', 'mythological']
        },
    ]
    
    export_batch(categories)
```

## 📊 Estrutura de Saída

```
wiktionary_exports/
├── English_nouns_Definition_part1.txt
├── English_nouns_Definition_part2.txt
└── ...

wiktionary_tracking/
└── exported_20260601_120000.json

logs/
└── wiktionary_export_20260601_120000.log
```

## ⚙️ Configuração Avançada

Edite os valores em `Config` para otimizar para sua máquina:

```python
class Config:
    # API
    REQUEST_DELAY = 1.0           # Segundos entre requisições
    MAX_BATCH_SIZE = 50           # Páginas por requisição
    MAX_RETRIES = 3               # Tentativas de retry
    RETRY_DELAY = 5.0             # Delay após erro
    
    # Para produção massiva, ajuste:
    REQUEST_DELAY = 0.5           # Requisições mais rápidas
    MAX_BATCH_SIZE = 100          # Batches maiores
```

## 🎨 Exemplos de Uso

### Exemplo 1: Exportar todos os nomes de animais

```python
exporter = WiktionaryExporter()
exporter.export(
    category='Animals',
    section='Definition',
    max_depth=4,
    include_keywords=['animal', 'creature'],
    exclude_keywords=['extinct', 'mythological']
)
```

### Exemplo 2: Exportar etimologias de palavras em português

```python
exporter = WiktionaryExporter()
exporter.export(
    category='Portuguese lemmas',
    section='Etymology',
    max_depth=3,
    max_pages=50000
)
```

### Exemplo 3: Exportação massiva de all English vocabulary

```python
exporter = WiktionaryExporter()
exporter.export(
    category='English lemmas',
    section='Definition',
    max_depth=5,
    max_pages=None,  # TUDO!
    exclude_keywords=['obsolete', 'archaic', 'rare', 'dialectal']
)
```

## 📈 Performance em Larga Escala

Para exportar **milhões de páginas**:

1. **Rodas em background**: Use `nohup` ou `screen`
   ```bash
   nohup python wiktionary_exporter.py > export.log 2>&1 &
   ```

2. **Monitor progresso**: 
   ```bash
   tail -f export.log
   ```

3. **Checkpoint automático**: O sistema salva tracking a cada página
   - Se parar no meio, pode continuar depois
   - Não reexporta páginas já processadas

4. **Paralelização** (múltiplas instâncias):
   ```bash
   # Terminal 1
   python script_categoria1.py &
   
   # Terminal 2
   python script_categoria2.py &
   
   # Terminal 3
   python script_categoria3.py &
   ```

## 🔍 Troubleshooting

### "Too many requests" (429)
- Aumente `REQUEST_DELAY` em `Config`
- Reduza `MAX_BATCH_SIZE`

### Conexão timeout
- Aumente `REQUEST_TIMEOUT`
- Aumente `RETRY_DELAY`

### Memória insuficiente (para milhões de páginas)
- Use `max_pages` para limitar por batch
- Processe em múltiplas instâncias separadas

## 📝 Formato de Output

Cada arquivo `.txt` contém:

```
================================================================================
TITLE: palavra
EXTRACTED: 2026-06-01T12:00:00
================================================================================

Conteúdo da seção...

================================================================================
TITLE: próxima_palavra
EXTRACTED: 2026-06-01T12:00:00
================================================================================
...
```

## 🛡️ Proteções Implementadas

- ✅ **User-Agent válido**: Identifica requisições com nome da ferramenta
- ✅ **Rate limiting**: Delay configurável entre requisições
- ✅ **Retry automático**: Re-tenta em caso de falha temporária
- ✅ **Batch size limite**: Não sobrecarrega a API com requisições gigantescas
- ✅ **Tracking**: Evita reexportar a mesma página
- ✅ **Logging**: Registra tudo para debug

## 📚 Referências

- [MediaWiki API Documentation](https://www.mediawiki.org/wiki/API:Main_page)
- [Wiktionary API Categories](https://en.wiktionary.org/w/api.php)
- [Wikipedia/Wiktionary Parsing](https://en.wikipedia.org/wiki/Wikipedia:API)

## 📄 Licença

MIT

---

**Desenvolvido para exportação em larga escala da Wiktionary**
