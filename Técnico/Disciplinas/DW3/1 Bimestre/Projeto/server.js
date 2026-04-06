import Fastify from 'fastify'
import cors from '@fastify/cors'

const server = Fastify()

// Habilita o CORS (origem pode ser controlada via env)
server.register(cors, {
    origin: process.env.CORS_ORIGIN || '*',
    methods: ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS']
})

const tarefas = [
    { id: 1, descricao: 'Fazer compras', concluido: false },
    { id: 2, descricao: 'Lavar o carro', concluido: false },
    { id: 3, descricao: 'Estudar Fastify', concluido: true },
    { id: 4, descricao: 'Estudar JavaScript', concluido: true }
]
    
// Helpers
const findIndexById = (id) => tarefas.findIndex(t => t.id === id)

// Ler todas as tarefas (com filtro opcional via query string)
server.get('/tarefas', async (request, reply) => {
    const busca = request.query?.busca
    if (busca) {
        const filtro = tarefas.filter(t => t.descricao.toLowerCase().includes(String(busca).toLowerCase()))
        return reply.send(filtro)
    }
    return reply.send(tarefas)
})

// Criar nova tarefa com validação mínima
server.post('/tarefas', async (request, reply) => {
    const { descricao } = request.body || {}
    if (!descricao || String(descricao).trim() === '') {
        return reply.status(400).send({ status: 'error', message: 'A descrição da tarefa é obrigatória' })
    }

    const novoId = tarefas.length > 0 ? tarefas[tarefas.length - 1].id + 1 : 1
    const novaTarefa = { id: novoId, descricao: String(descricao).trim(), concluido: false }
    tarefas.push(novaTarefa)

    return reply.status(201).send(novaTarefa)
})

// Ler tarefa específica
server.get('/tarefas/:id', async (request, reply) => {
    const id = Number(request.params.id)
    const tarefa = tarefas.find(t => t.id === id)
    if (!tarefa) return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })
    return reply.send(tarefa)
})

// Atualização parcial (PATCH)
server.patch('/tarefas/:id', async (request, reply) => {
    const id = Number(request.params.id)
    const index = findIndexById(id)
    if (index === -1) return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })

    const { descricao, concluido } = request.body || {}
    if (descricao !== undefined) tarefas[index].descricao = String(descricao).trim()
    if (concluido !== undefined) tarefas[index].concluido = Boolean(concluido)

    return reply.send(tarefas[index])
})

// Toggle concluir
server.patch('/tarefas/:id/concluir', async (request, reply) => {
    const id = Number(request.params.id)
    const index = findIndexById(id)
    if (index === -1) return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })

    tarefas[index].concluido = !tarefas[index].concluido
    return reply.send(tarefas[index])
})

// Deletar tarefa
server.delete('/tarefas/:id', async (request, reply) => {
    const id = Number(request.params.id)
    const index = findIndexById(id)
    if (index === -1) return reply.status(404).send({ status: 'error', message: 'Tarefa não encontrada' })

    tarefas.splice(index, 1)
    return reply.status(204).send()
})

// Resumo/estatísticas
server.get('/tarefas/resumo', async (request, reply) => {
    const total = tarefas.length
    const concluidas = tarefas.filter(t => t.concluido).length
    const pendentes = total - concluidas
    return reply.send({ total, concluidas, pendentes })
})

server.setNotFoundHandler((request, reply) => {
    reply.code(404).send({ status: 'error', message: 'O recurso solicitado não existe nesta API.' })
})

const PORT = Number(process.env.PORT) || 3000

const start = async () => {
    try {
        await server.listen({ port: PORT, host: '0.0.0.0' })
        console.log(`Servidor rodando em http://0.0.0.0:${PORT}`)
    } catch (erro) {
        console.error(erro)
        process.exit(1)
    }
}

start()