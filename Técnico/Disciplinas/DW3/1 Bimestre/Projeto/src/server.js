import Fastify from 'fastify'
import cors from '@fastify/cors'
import { tarefaRoutes } from './routes/tarefa.routes.js'
import TarefaRepository from './repositories/tarefa.repository.js'
import TarefaService from './services/tarefa.service.js'
import TarefaController from './controllers/tarefa.controller.js'

const server = Fastify()

// Instancia as dependências na ordem correta
const repository = TarefaRepository
const service = new TarefaService(repository)
const controller = new TarefaController(service)

// Habilita o CORS para permitir requisições do Frontend
server.register(cors, {
    origin: '*',
    methods: ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS']
})

server.register(tarefaRoutes, { prefix: '/tarefas', controller })

server.setNotFoundHandler((request, reply) => {
    reply.code(404).send({
        status: 'error',
        message: 'O recurso solicitado não existe nesta API.',
    })
})

const PORT = 3000

const start = async () => {
    try {
        await server.listen({ port: PORT })
        console.log(`Servidor rodando em http://localhost:${PORT}`)
    } catch (erro) {
        console.error(erro)
        process.exit(1)
    }
}

start()