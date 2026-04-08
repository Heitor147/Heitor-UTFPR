const tarefas = [
    { id: 1, descricao: "Fazer compras", concluido: false },
    { id: 2, descricao: "Lavar o carro", concluido: false },
    { id: 3, descricao: "Estudar Fastify", concluido: true },
    { id: 4, descricao: "Estudar JavaScript", concluido: true }
]

export function listarTarefas(request, reply) {
    console.log('Controller listarTarefas chamado');

    const busca = request.query?.busca

    if (busca) {
        const tarefasFiltradas = tarefas.filter(t =>
            t.descricao.toLowerCase().includes(busca.toLowerCase())
        )
        return reply.send(tarefasFiltradas)
    }

    return reply.send(tarefas)
}

export function criarTarefa(request, reply) {
    const { descricao } = request.body

    if (!descricao || descricao.trim() === '') {
        return reply.status(400).send({
            status: 'error',
            message: 'A descrição da tarefa é obrigatória'
        })
    }

    const novoId = tarefas.length > 0 ? tarefas[tarefas.length - 1].id + 1 : 1
    const novaTarefa = { id: novoId, descricao, concluido: false }

    tarefas.push(novaTarefa)
    return reply.status(201).send(novaTarefa)
}

export function obterTarefa(request, reply) {
    const id = Number(request.params.id)
    const tarefa = tarefas.find(t => t.id === id)

    if (!tarefa) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    return reply.send(tarefa)
}

export function atualizarTarefa(request, reply) {
    const id = Number(request.params.id)
    const index = tarefas.findIndex(t => t.id === id)

    if (index === -1) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    const tarefaAtualizada = request.body
    tarefas[index] = { ...tarefas[index], ...tarefaAtualizada, id }

    return reply.send(tarefas[index])
}

export function concluirTarefa(request, reply) {
    const id = Number(request.params.id)
    const index = tarefas.findIndex(t => t.id === id)

    if (index === -1) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    tarefas[index].concluido = !tarefas[index].concluido
    return reply.send(tarefas[index])
}

export function removerTarefa(request, reply) {
    const id = Number(request.params.id)
    const index = tarefas.findIndex(t => t.id === id)

    if (index === -1) {
        return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    }

    tarefas.splice(index, 1)
    return reply.status(204).send()
}

export function resumoTarefas(request, reply) {
    const total = tarefas.length
    const concluidas = tarefas.filter(t => t.concluido).length
    const pendentes = total - concluidas

    return reply.send({
        total,
        concluidas,
        pendentes
    })
}
