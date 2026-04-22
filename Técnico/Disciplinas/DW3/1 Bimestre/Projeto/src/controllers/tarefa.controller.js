import tarefaModel from '../models/tarefa.model.js'

export async function listarTarefas(request, reply) {
    console.log('Controller listarTarefas chamado');
    const busca = request.query?.busca
    const resultado = await tarefaModel.listar(busca)
    return reply.send(resultado)
}

export async function criarTarefa(request, reply) {
    const { descricao } = request.body

    if (!descricao || descricao.trim() === '') {
        return reply.status(400).send({
            status: 'error',
            message: 'A descrição da tarefa é obrigatória'
        })
    }

    const nova = await tarefaModel.criar(descricao)
    return reply.status(201).send(nova)
}

export async function obterTarefa(request, reply) {
    const id = Number(request.params.id)
    const tarefa = await tarefaModel.buscarPorId(id)

    if (!tarefa) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    return reply.send(tarefa)
}

export async function atualizarTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await tarefaModel.buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    const tarefaAtualizada = await tarefaModel.atualizar(id, request.body)
    return reply.send(tarefaAtualizada)
}

export async function concluirTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await tarefaModel.buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    const atualizado = await tarefaModel.atualizar(id, { ...existente, concluido: !existente.concluido })
    return reply.send(atualizado)
}

export async function removerTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await tarefaModel.buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    await tarefaModel.remover(id)
    return reply.status(204).send()
}

export async function resumoTarefas(request, reply) {
    const resumo = await tarefaModel.obterResumo()
    return reply.send(resumo)
}

export async function listarTarefasPendentes(request, reply) {
    console.log('Controller listarTarefasPendentes chamado')
    const resultado = await tarefaModel.listarPendentes()
    return reply.send(resultado)
}
