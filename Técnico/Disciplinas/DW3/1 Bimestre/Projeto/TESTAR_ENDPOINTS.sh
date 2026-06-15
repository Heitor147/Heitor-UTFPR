#!/bin/bash

# =====================================================
# TESTES DO SISTEMA DE EXCEÇÕES - FASTIFY
# =====================================================
# 
# Use este arquivo para testar manualmente o sistema
# de tratamento de exceções implementado.
#
# Pré-requisito: Servidor rodando em http://localhost:3000
#

echo "========================================"
echo "TESTANDO SISTEMA DE EXCEÇÕES - FASTIFY" 
echo "========================================"
echo ""

# ============= TESTE 1: DIVISÃO SEGURA =============
echo "🔢 TESTE 1: Divisão Segura"
echo "---"

echo "✅ Teste 1a: Divisão válida (10 / 2)"
curl -s "http://localhost:3000/exemplos/divisao?dividendo=10&divisor=2" | jq .
echo ""

echo "❌ Teste 1b: Divisão por zero"
curl -s "http://localhost:3000/exemplos/divisao?dividendo=10&divisor=0" | jq .
echo ""

echo "❌ Teste 1c: Parâmetros não são números"
curl -s "http://localhost:3000/exemplos/divisao?dividendo=abc&divisor=2" | jq .
echo ""

# ============= TESTE 2: CADASTRO DE PRODUTO =============
echo ""
echo "📦 TESTE 2: Cadastro de Produto"
echo "---"

echo "✅ Teste 2a: Cadastro válido"
curl -s -X POST "http://localhost:3000/exemplos/produtos" \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Notebook Dell",
    "preco": 3500,
    "categoria": "Eletrônicos"
  }' | jq .
echo ""

echo "❌ Teste 2b: Falta campo 'nome'"
curl -s -X POST "http://localhost:3000/exemplos/produtos" \
  -H "Content-Type: application/json" \
  -d '{
    "preco": 3500,
    "categoria": "Eletrônicos"
  }' | jq .
echo ""

echo "❌ Teste 2c: Preço inválido (zero)"
curl -s -X POST "http://localhost:3000/exemplos/produtos" \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Mouse",
    "preco": 0,
    "categoria": "Periféricos"
  }' | jq .
echo ""

echo "❌ Teste 2d: Categoria vazia"
curl -s -X POST "http://localhost:3000/exemplos/produtos" \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Teclado",
    "preco": 150,
    "categoria": ""
  }' | jq .
echo ""

# ============= TESTE 3: BUSCA DE USUÁRIO =============
echo ""
echo "👤 TESTE 3: Busca de Usuário"
echo "---"

echo "✅ Teste 3a: Buscar usuário existente (ID 1)"
curl -s "http://localhost:3000/exemplos/usuarios/1" | jq .
echo ""

echo "✅ Teste 3b: Buscar usuário existente (ID 2)"
curl -s "http://localhost:3000/exemplos/usuarios/2" | jq .
echo ""

echo "❌ Teste 3c: Buscar usuário inexistente (ID 999)"
curl -s "http://localhost:3000/exemplos/usuarios/999" | jq .
echo ""

# ============= TESTE 4: ATUALIZAR STATUS =============
echo ""
echo "🔄 TESTE 4: Atualizar Status do Usuário"
echo "---"

echo "✅ Teste 4a: Atualizar status válido (Alice: ativo=true para false)"
curl -s -X PATCH "http://localhost:3000/exemplos/usuarios/1/status" \
  -H "Content-Type: application/json" \
  -d '{ "ativo": false }' | jq .
echo ""

echo "❌ Teste 4b: Tentar atualizar para status já existente (David: ativo=true para true)"
curl -s -X PATCH "http://localhost:3000/exemplos/usuarios/4/status" \
  -H "Content-Type: application/json" \
  -d '{ "ativo": true }' | jq .
echo ""

echo "❌ Teste 4c: Atualizar usuário inexistente (ID 999)"
curl -s -X PATCH "http://localhost:3000/exemplos/usuarios/999/status" \
  -H "Content-Type: application/json" \
  -d '{ "ativo": false }' | jq .
echo ""

# ============= TESTE 5: TAREFAS REFATORADAS =============
echo ""
echo "✅ TESTE 5: Tarefas Refatoradas com Exceções"
echo "---"

echo "✅ Teste 5a: Criar tarefa válida"
curl -s -X POST "http://localhost:3000/tarefas" \
  -H "Content-Type: application/json" \
  -d '{ "descricao": "Estudar Exceptions em Node.js" }' | jq .
echo ""

echo "❌ Teste 5b: Tentar criar tarefa com descrição vazia"
curl -s -X POST "http://localhost:3000/tarefas" \
  -H "Content-Type: application/json" \
  -d '{ "descricao": "" }' | jq .
echo ""

echo "✅ Teste 5c: Listar todas as tarefas"
curl -s "http://localhost:3000/tarefas" | jq .
echo ""

echo "✅ Teste 5d: Obter tarefa específica (ID 1)"
curl -s "http://localhost:3000/tarefas/1" | jq .
echo ""

echo "❌ Teste 5e: Obter tarefa inexistente (ID 999)"
curl -s "http://localhost:3000/tarefas/999" | jq .
echo ""

echo "✅ Teste 5f: Atualizar tarefa (ID 1)"
curl -s -X PATCH "http://localhost:3000/tarefas/1" \
  -H "Content-Type: application/json" \
  -d '{ "descricao": "Estudar Fastify com Exceptions" }' | jq .
echo ""

echo "❌ Teste 5g: Atualizar tarefa inexistente (ID 999)"
curl -s -X PATCH "http://localhost:3000/tarefas/999" \
  -H "Content-Type: application/json" \
  -d '{ "descricao": "Nova descrição" }' | jq .
echo ""

echo "✅ Teste 5h: Alternar conclusão da tarefa (ID 1)"
curl -s -X PATCH "http://localhost:3000/tarefas/1/concluir" | jq .
echo ""

echo "✅ Teste 5i: Obter resumo de tarefas"
curl -s "http://localhost:3000/tarefas/resumo" | jq .
echo ""

echo "✅ Teste 5j: Remover tarefa (ID 2)"
curl -s -X DELETE "http://localhost:3000/tarefas/2"
echo ""

echo "❌ Teste 5k: Remover tarefa inexistente (ID 999)"
curl -s -X DELETE "http://localhost:3000/tarefas/999" | jq .
echo ""

# ============= TESTE 6: ROTA NÃO ENCONTRADA =============
echo ""
echo "❌ TESTE 6: Rota Não Encontrada"
echo "---"

echo "Teste 6a: Acessar rota inexistente"
curl -s "http://localhost:3000/rota/inexistente" | jq .
echo ""

echo "========================================"
echo "✅ TESTES COMPLETOS!"
echo "========================================"
