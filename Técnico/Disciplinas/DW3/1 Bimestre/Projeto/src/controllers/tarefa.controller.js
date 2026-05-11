class TarefaController {
    constructor(service) {
        this.service = service
        this.listarTarefas = this.listarTarefas.bind(this)
        this.criarTarefa = this.criarTarefa.bind(this)
        this.obterTarefa = this.obterTarefa.bind(this)
        this.atualizarTarefa = this.atualizarTarefa.bind(this)
        this.concluirTarefa = this.concluirTarefa.bind(this)
        this.removerTarefa = this.removerTarefa.bind(this)
        this.resumoTarefas = this.resumoTarefas.bind(this)
        this.obterPendentes = this.obterPendentes.bind(this)
    }

    async listarTarefas(request, reply) {
        console.log('Controller listarTarefas chamado');
        const busca = request.query?.busca
        const concluido = request.query?.concluido
        const opcoes = {}
        if (busca) opcoes.busca = busca
        if (concluido) opcoes.concluido = concluido
        const resultado = await this.service.listar(opcoes)
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

        const nova = await this.service.criar(descricao)
        return reply.status(201).send(nova)
    }

    async obterTarefa(request, reply) {
        const id = Number(request.params.id)
        const tarefa = await this.service.buscarPorId(id)

        if (!tarefa) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        return reply.send(tarefa)
    }

    async atualizarTarefa(request, reply) {
        const id = Number(request.params.id)
        const existente = await this.service.buscarPorId(id)

        if (!existente) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        const tarefaAtualizada = await this.service.atualizar(id, request.body)
        return reply.send(tarefaAtualizada)
    }

    async concluirTarefa(request, reply) {
        const id = Number(request.params.id)
        const atualizado = await this.service.alternarConcluido(id)

        if (!atualizado) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        return reply.send(atualizado)
    }

    async removerTarefa(request, reply) {
        const id = Number(request.params.id)
        const existente = await this.service.buscarPorId(id)

        if (!existente) {
            return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
        }

        await this.service.remover(id)
        return reply.status(204).send()
    }

    async resumoTarefas(request, reply) {
        const resumo = await this.service.obterResumo()
        return reply.send(resumo)
    }

    async obterPendentes(request, reply) {
        console.log('Controller obterPendentes chamado')
        const resultado = await this.service.listar({ concluido: 'false' })
        return reply.send(resultado)
    }
}

export default TarefaController
