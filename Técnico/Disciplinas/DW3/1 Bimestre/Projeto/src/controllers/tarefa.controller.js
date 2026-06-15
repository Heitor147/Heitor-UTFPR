import { AppError } from '../errors/AppError.js'

class TarefaController {
  constructor(service) {
    this.service = service
  }

  async listarTarefas(request, reply) {
    console.log("Controller: listarTarefas chamado")
    const { busca, concluido } = request.query
    const resultado = await this.service.listar({ busca, concluido })
    return reply.send(resultado)
  }

  async criarTarefa(request, reply) {
    console.log("Controller: criarTarefa chamado")
    const { descricao } = request.body
    if (!descricao || descricao.trim() === '') {
      throw new AppError('A descrição da tarefa é obrigatória', 400)
    }
    const novaTarefa = await this.service.criar(descricao)
    return reply.status(201).send(novaTarefa)
  }

  async obterTarefa(request, reply) {
    console.log("Controller: obterTarefa chamado")
    const id = Number(request.params.id)
    const tarefa = await this.service.buscarPorId(id)
    return reply.send(tarefa)
  }

  async atualizarTarefa(request, reply) {
    console.log("Controller: atualizarTarefa chamado")
    const id = Number(request.params.id)
    const tarefa = await this.service.atualizar(id, request.body)
    return reply.send(tarefa)
  }

  async concluirTarefa(request, reply) {
    console.log("Controller: concluirTarefa chamado")
    const id = Number(request.params.id)
    const tarefa = await this.service.alternarConcluido(id)
    return reply.send(tarefa)
  }

  async removerTarefa(request, reply) {
    console.log("Controller: removerTarefa chamado")
    const id = Number(request.params.id)
    await this.service.remover(id)
    return reply.status(204).send()
  }

  async obterResumo(request, reply) {
    console.log("Controller: obterResumo chamado")
    const resumo = await this.service.obterResumo()
    return reply.send(resumo)
  }
}

export default TarefaController
