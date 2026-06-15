/**
 * exemplos.routes.js
 * Rotas para testar as funções de exemplo de tratamento de exceções
 */

import ExemplosController from './exemplos.controller.js'

export default async function exemplosRoutes(server, options) {
  const controller = new ExemplosController()

  // Divisão segura
  server.get('/divisao', async (request, reply) => {
    console.log('Routes: GET /divisao chamada')
    return controller.testarDivisao(request, reply)
  })

  // Cadastro de produto
  server.post('/produtos', async (request, reply) => {
    console.log('Routes: POST /produtos chamada')
    return controller.criarProduto(request, reply)
  })

  // Busca de usuário
  server.get('/usuarios/:id', async (request, reply) => {
    console.log('Routes: GET /usuarios/:id chamada')
    return controller.obterUsuario(request, reply)
  })

  // Atualizar status do usuário
  server.patch('/usuarios/:id/status', async (request, reply) => {
    console.log('Routes: PATCH /usuarios/:id/status chamada')
    return controller.atualizarStatus(request, reply)
  })
}
