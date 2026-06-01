.PHONY: help setup install test run-interactive run-batch clean logs

help:
	@echo "Wiktionary Exporter - Comandos Disponíveis"
	@echo ""
	@echo "  make setup              Configura ambiente (venv + dependências)"
	@echo "  make install            Instala dependências apenas"
	@echo "  make test               Executa testes rápidos"
	@echo "  make run-interactive    Modo interativo"
	@echo "  make run-batch          Exportação em batch (produção)"
	@echo "  make run-production     Alias para run-batch"
	@echo "  make logs               Mostra últimos logs"
	@echo "  make clean              Remove arquivos gerados (/exports, /tracking, /logs)"
	@echo ""

setup:
	@echo "⚙️  Configurando ambiente..."
	@chmod +x setup.sh
	@./setup.sh

install:
	@echo "📦 Instalando dependências..."
	@pip install -r requirements.txt

test:
	@echo "🧪 Executando testes..."
	@python3 test_quick_start.py

run-interactive:
	@echo "🚀 Modo interativo..."
	@python3 wiktionary_exporter.py

run-batch:
	@echo "🚀 Exportação em batch (produção)..."
	@python3 export_production.py batch

run-batch-custom:
	@echo "🚀 Exportação customizada..."
	@python3 export_production.py custom

run-production: run-batch

logs:
	@if [ -d "logs" ]; then \
		echo "📄 Últimos 50 linhas de logs:"; \
		tail -50 logs/*.log 2>/dev/null || echo "Nenhum log encontrado"; \
	else \
		echo "❌ Diretório de logs não encontrado"; \
	fi

status:
	@echo "📊 Status da exportação:"
	@if [ -d "wiktionary_tracking" ]; then \
		ls -lh wiktionary_tracking/*.json 2>/dev/null | tail -5 || echo "Nenhum tracking encontrado"; \
	else \
		echo "❌ Nenhuma exportação ainda"; \
	fi

clean:
	@echo "🧹 Limpando arquivos gerados..."
	@rm -rf wiktionary_exports/* wiktionary_tracking/* logs/*
	@echo "✅ Limpeza concluída"

clean-venv:
	@echo "🧹 Removendo ambiente virtual..."
	@rm -rf venv/
	@echo "✅ Ambiente virtual removido"

full-clean: clean clean-venv
	@echo "✅ Limpeza completa concluída"

.PHONY: help setup install test run-interactive run-batch run-batch-custom logs status clean clean-venv full-clean
