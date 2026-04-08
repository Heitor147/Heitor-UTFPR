import { listar, criar, buscarPorId, atualizar, remover, obterResumo, listarPendentes } from '../models/tarefa.model.js'

export async function listarTarefas(request, reply) {
    console.log('Controller listarTarefas chamado');
    const busca = request.query?.busca
    const resultado = await listar(busca)
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

    const nova = await criar(descricao)
    return reply.status(201).send(nova)
}

export async function obterTarefa(request, reply) {
    const id = Number(request.params.id)
    const tarefa = await buscarPorId(id)

    if (!tarefa) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    return reply.send(tarefa)
}

export async function atualizarTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    const tarefaAtualizada = await atualizar(id, request.body)
    return reply.send(tarefaAtualizada)
}

export async function concluirTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    const atualizado = await atualizar(id, { ...existente, concluido: !existente.concluido })
    return reply.send(atualizado)
}

export async function removerTarefa(request, reply) {
    const id = Number(request.params.id)
    const existente = await buscarPorId(id)

    if (!existente) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    await remover(id)
    return reply.status(204).send()
}

export async function resumoTarefas(request, reply) {
    const resumo = await obterResumo()
    return reply.send(resumo)
}

export async function listarTarefasPendentes(request, reply) {
    console.log('Controller listarTarefasPendentes chamado')
    const resultado = await listarPendentes()
    return reply.send(resultado)
}
