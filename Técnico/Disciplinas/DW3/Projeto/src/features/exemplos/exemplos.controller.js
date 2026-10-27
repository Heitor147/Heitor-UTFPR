/**
 * exemplos.controller.js
 * Controller para testar as funções de exemplo com tratamento de exceções
 */

import { divisaoSegura, cadastrarProduto, buscarUsuario, atualizarStatusUsuario } from './exemplos.service.js'

export class ExemplosController {
  /**
   * Endpoint para testar divisão segura
   * GET /exemplos/divisao?dividendo=10&divisor=2
   */
  async testarDivisao(request, reply) {
    const { dividendo, divisor } = request.query
    
    const div = Number(dividendo)
    const dis = Number(divisor)
    
    const resultado = await divisaoSegura(div, dis)
    return reply.send({ resultado })
  }

  /**
   * Endpoint para cadastrar um produto
   * POST /exemplos/produtos
   * Body: { "nome": "Notebook", "preco": 2500, "categoria": "Eletrônicos" }
   */
  async criarProduto(request, reply) {
    const produto = await cadastrarProduto(request.body)
    return reply.status(201).send(produto)
  }

  /**
   * Endpoint para buscar um usuário
   * GET /exemplos/usuarios/:id
   */
  async obterUsuario(request, reply) {
    const usuarioId = Number(request.params.id)
    const usuario = await buscarUsuario(usuarioId)
    return reply.send(usuario)
  }

  /**
   * Endpoint para atualizar o status de um usuário
   * PATCH /exemplos/usuarios/:id/status
   * Body: { "ativo": true }
   */
  async atualizarStatus(request, reply) {
    const usuarioId = Number(request.params.id)
    const { ativo } = request.body
    
    const usuarioAtualizado = await atualizarStatusUsuario(usuarioId, ativo)
    return reply.send(usuarioAtualizado)
  }
}

export default ExemplosController
