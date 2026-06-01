# 🚀 Getting Started - Começando em 5 minutos

## Instalação

### Opção 1: Setup Automático (Recomendado)

```bash
chmod +x setup.sh
./setup.sh
```

Pronto! ✅

### Opção 2: Manual

```bash
# 1. Criar ambiente virtual
python3 -m venv venv
source venv/bin/activate  # No Windows: venv\Scripts\activate

# 2. Instalar dependências
pip install -r requirements.txt

# 3. Criar diretórios
mkdir -p wiktionary_exports wiktionary_tracking logs
```

---

## Começar a usar

### Modo 1: Interativo (mais simples)

```bash
python3 wiktionary_exporter.py
```

Responda as perguntas:
- Categoria (ex: `English nouns`)
- Seção (ex: `Definition`)
- Profundidade (1-5)
- Máximo de páginas (opcional)
- Palavras-chave (opcional)

---

### Modo 2: Testes rápidos

```bash
python3 test_quick_start.py
```

Escolha um teste e execute!

---

### Modo 3: Produção (múltiplas categorias)

```bash
python3 export_production.py
```

Ou customize em `export_production.py` e rode novamente.

---

## 📊 Onde ficam os arquivos exportados?

```
wiktionary_exports/
├── English_nouns_Definition_part1.txt
├── English_nouns_Definition_part2.txt
└── ...
```

Abra qualquer `.txt` para ver os artigos!

---

## 🔍 Monitorar progresso

Durante a execução, você verá:

```
Explorando categorias: 45%|███░░░░░░░| 450/1000 [01:23<02:10]
Exportando páginas: 78%|██████░░░░| 3450/5000 [12:34<04:12]
```

As barras de progresso mostram em real-time.

---

## 📝 Documentação completa

Para mais detalhes, leia:
- `README_WIKTIONARY_EXPORTER.md` - Guia completo de uso
- `TECHNICAL_DOCS.md` - Documentação técnica (para devs)

---

## ⚡ Dicas rápidas

### Exportação rápida (teste)
```bash
# Edite wiktionary_exporter.py, main():
exporter.export(
    category='English nouns starting with A',
    section='Definition',
    max_depth=1,
    max_pages=50  # Rápido!
)
```

### Exportação massiva (produção)
```bash
# Use export_production.py
# Roda múltiplas categorias em sequência
# Pode deixar executando em background
```

### Resumir depois de interrupção
```bash
# Sistema de checkpoint automático!
# Se parou no meio, próxima execução continua de onde parou
# Não reexporta páginas já feitas
```

---

## 🐛 Problemas?

### "429 Too Many Requests"
Aumentar delay entre requisições:
```python
# Em wiktionary_exporter.py, em Config:
REQUEST_DELAY = 2.0  # Aumentar este valor
```

### "Timeout"
```python
REQUEST_TIMEOUT = 60  # Aumentar para 60 segundos
```

### Seção não encontrada
```python
# Tente outras seções:
'Definition'
'Etymology'
'Pronunciation'
'Usage notes'
'Synonyms'
# etc.
```

---

## 📞 Próximos passos

1. ✅ Instalar (`./setup.sh`)
2. ✅ Testar (`python3 test_quick_start.py`)
3. ✅ Usar modo interativo (`python3 wiktionary_exporter.py`)
4. ✅ Para produção: editar e rodar `export_production.py`

---

**Tudo pronto? Execute agora:**

```bash
python3 test_quick_start.py
```

🎉
