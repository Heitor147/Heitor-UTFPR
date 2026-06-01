#!/bin/bash
# setup.sh - Script de setup automático

echo "=========================================="
echo "Wiktionary Exporter - Setup Automático"
echo "=========================================="

# Verificar Python
echo ""
echo "✓ Verificando Python..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 não encontrado! Instale com:"
    echo "   Ubuntu/Debian: sudo apt-get install python3 python3-pip"
    echo "   macOS: brew install python3"
    echo "   Windows: https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo "  → $PYTHON_VERSION (OK)"

# Criar venv
echo ""
echo "✓ Criando ambiente virtual..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "  → Ambiente 'venv' criado"
else
    echo "  → Ambiente 'venv' já existe"
fi

# Ativar venv
echo ""
echo "✓ Ativando ambiente virtual..."
source venv/bin/activate
echo "  → Ambiente ativado"

# Instalar dependências
echo ""
echo "✓ Instalando dependências..."
pip install --upgrade pip > /dev/null 2>&1
pip install -r requirements.txt
echo "  → Dependências instaladas"

# Criar diretórios
echo ""
echo "✓ Criando diretórios..."
mkdir -p wiktionary_exports wiktionary_tracking logs
echo "  → Diretórios criados"

# Resumo
echo ""
echo "=========================================="
echo "✅ Setup concluído!"
echo "=========================================="
echo ""
echo "Próximos passos:"
echo ""
echo "1. Ativar ambiente virtual:"
echo "   $ source venv/bin/activate"
echo ""
echo "2. Executar modo interativo:"
echo "   $ python3 wiktionary_exporter.py"
echo ""
echo "3. Ou rodar testes:"
echo "   $ python3 test_quick_start.py"
echo ""
echo "4. Ou usar para produção:"
echo "   $ python3 export_production.py"
echo ""
echo "=========================================="
