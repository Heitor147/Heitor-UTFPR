import tarefaModel from '../models/tarefa.model.js'

class TarefaController {
    constructor(model) {
        this.model = model
    }

    async listarTarefas(request, reply) {
        console.log('Controller listarTarefas chamado');
        const busca = request.query?.busca
        const resultado = await this.model.listar(busca)
        return reply.send(resultado)
    }

    async criarTarefa(request, reply) {
        const { descricao } = request.body

        if (!descricao || descricao.trim() === '') {
            return reply.status(400).send({
                status: 'error',
                message: 'A descrição da tarefa é obrigatória'
            })
        }

        const nova = await this.model.criar(descricao)
        return reply.status(201).send(nova)
    }

    async obterTarefa(request, reply) {
        const id = Number(request.params.id)
        const tarefa = await this.model.buscarPorId(id)

        if (!tarefa) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        return reply.send(tarefa)
    }

    async atualizarTarefa(request, reply) {
        const id = Number(request.params.id)
        const existente = await this.model.buscarPorId(id)

        if (!existente) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        const tarefaAtualizada = await this.model.atualizar(id, request.body)
        return reply.send(tarefaAtualizada)
    }

    async concluirTarefa(request, reply) {
        const id = Number(request.params.id)
        const existente = await this.model.buscarPorId(id)

        if (!existente) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        const atualizado = await this.model.atualizar(id, { ...existente, concluido: !existente.concluido })
        return reply.send(atualizado)
    }

    async removerTarefa(request, reply) {
        const id = Number(request.params.id)
        const existente = await this.model.buscarPorId(id)

        if (!existente) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        await this.model.remover(id)
        return reply.status(204).send()
    }

    async resumoTarefas(request, reply) {
        const resumo = await this.model.obterResumo()
        return reply.send(resumo)
    }

    async listarTarefasPendentes(request, reply) {
        console.log('Controller listarTarefasPendentes chamado')
        const resultado = await this.model.listarPendentes()
        return reply.send(resultado)
    }
}

export default new TarefaController(tarefaModel)
