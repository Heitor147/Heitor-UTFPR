/**
 * Documentação e Exemplos de Testes - Sistema de Tratamento de Exceções
 * Baseado no Roteiro 09 Complementar
 * 
 * Este arquivo contém exemplos de como usar as endpoints para testar
 * o sistema avançado de tratamento de exceções.
 */

// ============================================
// TESTE 1: Divisão Segura
// ============================================
// URL: GET /exemplos/divisao?dividendo=10&divisor=2
// 
// Casos de Sucesso:
// - GET /exemplos/divisao?dividendo=10&divisor=2
//   Resposta: { "resultado": 5 }
// 
// Casos de Erro (ValidationError - 400):
// - GET /exemplos/divisao?dividendo=10&divisor=0
//   Resposta: {
//     "status": "error",
//     "name": "ValidationError",
//     "message": "O divisor não pode ser zero. Operação matemática inválida.",
//     "statusCode": 400
//   }
// 
// - GET /exemplos/divisao?dividendo=abc&divisor=2
//   Resposta: {
//     "status": "error",
//     "name": "ValidationError",
//     "message": "Dividendo e divisor devem ser números.",
//     "statusCode": 400
//   }

// ============================================
// TESTE 2: Cadastro de Produto
// ============================================
// URL: POST /exemplos/produtos
// Content-Type: application/json
// 
// Caso de Sucesso:
// POST /exemplos/produtos
// Body: {
//   "nome": "Notebook Dell",
//   "preco": 3500,
//   "categoria": "Eletrônicos"
// }
// 
// Resposta (201 Created): {
//   "id": 5742,
//   "nome": "Notebook Dell",
//   "preco": 3500,
//   "categoria": "Eletrônicos",
//   "dataCadastro": "2026-06-15T10:30:00.000Z"
// }
// 
// Casos de Erro (ValidationError - 400):
// 
// - Falta do campo "nome":
// Body: { "preco": 3500, "categoria": "Eletrônicos" }
// Resposta: {
//   "status": "error",
//   "name": "ValidationError",
//   "message": "O campo \"nome\" é obrigatório e deve ser uma string não vazia.",
//   "statusCode": 400
// }
// 
// - Preço inválido (zero ou negativo):
// Body: {
//   "nome": "Notebook",
//   "preco": 0,
//   "categoria": "Eletrônicos"
// }
// Resposta: {
//   "status": "error",
//   "name": "ValidationError",
//   "message": "O campo \"preco\" é obrigatório e deve ser um número maior que zero.",
//   "statusCode": 400
// }
// 
// - Campo categoria vazio:
// Body: {
//   "nome": "Mouse",
//   "preco": 50,
//   "categoria": ""
// }
// Resposta: {
//   "status": "error",
//   "name": "ValidationError",
//   "message": "O campo \"categoria\" é obrigatório e deve ser uma string não vazia.",
//   "statusCode": 400
// }

// ============================================
// TESTE 3: Busca de Usuário
// ============================================
// URL: GET /exemplos/usuarios/:id
// 
// Usuários disponíveis na base simulada:
// - ID 1: Alice Silva (alice@example.com) - ativo
// - ID 2: Bob Johnson (bob@example.com) - ativo
// - ID 3: Carol Davis (carol@example.com) - inativo
// - ID 4: David Chen (david@example.com) - ativo
// 
// Caso de Sucesso:
// - GET /exemplos/usuarios/1
// Resposta: {
//   "id": 1,
//   "nome": "Alice Silva",
//   "email": "alice@example.com",
//   "ativo": true
// }
// 
// Caso de Erro (NotFoundError - 404):
// - GET /exemplos/usuarios/999
// Resposta: {
//   "status": "error",
//   "name": "NotFoundError",
//   "message": "Usuário com ID 999 não encontrado na base de dados.",
//   "statusCode": 404
// }

// ============================================
// TESTE 4: Atualizar Status do Usuário
// ============================================
// URL: PATCH /exemplos/usuarios/:id/status
// Content-Type: application/json
// 
// Caso de Sucesso:
// PATCH /exemplos/usuarios/1/status
// Body: { "ativo": false }
// Resposta: {
//   "id": 1,
//   "nome": "Alice Silva",
//   "email": "alice@example.com",
//   "ativo": false,
//   "dataUltimaAtualizacao": "2026-06-15T10:45:00.000Z"
// }
// 
// Casos de Erro:
// 
// - Usuário não encontrado (NotFoundError - 404):
// PATCH /exemplos/usuarios/999/status
// Body: { "ativo": true }
// Resposta: {
//   "status": "error",
//   "name": "NotFoundError",
//   "message": "Usuário com ID 999 não encontrado na base de dados.",
//   "statusCode": 404
// }
// 
// - Status já é o mesmo (ConflictError - 409):
// PATCH /exemplos/usuarios/1/status
// Body: { "ativo": true }  (e o usuário 1 já está ativo)
// Resposta: {
//   "status": "error",
//   "name": "ConflictError",
//   "message": "O usuário já possui o status \"true\". Nenhuma alteração necessária.",
//   "statusCode": 409
// }

// ============================================
// TESTE 5: Rotas de Tarefas (Refatoradas)
// ============================================
// 
// Criar Tarefa:
// POST /tarefas
// Body: { "descricao": "Estudar Node.js" }
// Sucesso (201): { "id": N, "descricao": "...", "concluido": false }
// Erro (400): Se descrição vazia ou não string
// 
// Listar Tarefas:
// GET /tarefas
// GET /tarefas?busca=node
// GET /tarefas?concluido=true
// 
// Obter Tarefa:
// GET /tarefas/1
// Sucesso: { "id": 1, "descricao": "...", "concluido": false }
// Erro (404): Se tarefa não existe
// 
// Atualizar Tarefa:
// PATCH /tarefas/1
// Body: { "descricao": "Novo título" }
// Sucesso: Tarefa atualizada
// Erro (404): Se tarefa não existe
// 
// Alternar Conclusão:
// PATCH /tarefas/1/concluir
// Sucesso: Tarefa com status invertido
// Erro (404): Se tarefa não existe
// 
// Remover Tarefa:
// DELETE /tarefas/1
// Sucesso (204): Sem conteúdo
// Erro (404): Se tarefa não existe
// 
// Obter Resumo:
// GET /tarefas/resumo
// Resposta: { "total": N, "concluidas": N, "pendentes": N }

// ============================================
// ARQUITETURA DO SISTEMA DE EXCEÇÕES
// ============================================
// 
// 1. Classes Base:
//    src/shared/errors/AppError.js
//    - AppError (statusCode, isOperational=true)
//    - ValidationError (extends AppError, status 400)
//    - NotFoundError (extends AppError, status 404)
//    - ConflictError (extends AppError, status 409)
//    - UnauthorizedError (extends AppError, status 401)
//    - ForbiddenError (extends AppError, status 403)
// 
// 2. Camada de Serviço (Service):
//    - Remove retornos null/undefined
//    - Lança exceções specific com throw new [ErrorType](message)
//    src/services/tarefa.service.js
//    src/features/exemplos/exemplos.service.js
// 
// 3. Camada de Apresentação (Controller):
//    - Focus no happy path (fluxo feliz)
//    - Sem validações redundantes
//    - Sem blocos try/catch internos
//    src/controllers/tarefa.controller.js
//    src/features/exemplos/exemplos.controller.js
// 
// 4. Error Handler Global (server.js):
//    - Usa instanceof para checking de tipos
//    - Captura AppError e retorna statusCode/message
//    - Captura erros do Fastify
//    - Erros desconhecidos retornam 500 sem expor detalhes
//    - Log detalhado para debugging interno

// ============================================
// PROTOCOLO DE RESPOSTA PADRONIZADO
// ============================================
// 
// Sucesso (2xx):
// {
//   <dados específicos da operação>
// }
// 
// Erro Operacional (4xx):
// {
//   "status": "error",
//   "name": "ValidationError|NotFoundError|ConflictError|...",
//   "message": "Descrição do erro",
//   "statusCode": 400|404|409|...
// }
// 
// Erro não Operacional (5xx):
// {
//   "status": "error",
//   "message": "Erro interno do servidor. Entre em contato com o suporte.",
//   "errorId": "ID para rastreamento"
// }

export default {}
