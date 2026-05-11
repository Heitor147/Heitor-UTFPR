import Fastify from 'fastify'
import cors from '@fastify/cors'
import tarefaRoutes from './routes/tarefa.routes.js'
import TarefaRepository from './repositories/tarefa.repository.js'
import TarefaService from './services/tarefa.service.js'
import TarefaController from './controllers/tarefa.controller.js'

const server = Fastify()

// Habilita CORS
server.register(cors, {
  origin: '*',
  methods: ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS']
})

// ========================================
// Composition Root: Dependency Injection
// ========================================
// Cria as instâncias na ordem correta
const repository = new TarefaRepository()
const service = new TarefaService(repository)
const controller = new TarefaController(service)

// Registra as rotas, injetando o controller
server.register(tarefaRoutes, { prefix: '/tarefas', controller })

// Handler para rotas não encontradas
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