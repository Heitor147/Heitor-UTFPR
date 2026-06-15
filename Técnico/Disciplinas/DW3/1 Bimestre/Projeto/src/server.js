import Fastify from 'fastify'
import cors from '@fastify/cors'
import tarefaRoutes from './routes/tarefa.routes.js'
import TarefaRepository from './repositories/tarefa.repository.js'
import TarefaService from './services/tarefa.service.js'
import TarefaController from './controllers/tarefa.controller.js'
import { 
  AppError, 
  ValidationError, 
  NotFoundError, 
  ConflictError,
  UnauthorizedError,
  ForbiddenError 
} from './shared/errors/AppError.js'
import exemplosRoutes from './features/exemplos/exemplos.routes.js'

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

// Registra as rotas de exemplos (testes de exceções)
server.register(exemplosRoutes, { prefix: '/exemplos' })

// ========================================
// Error Handler Global
// ========================================
server.setErrorHandler((error, request, reply) => {
  console.error('Error Handler capturou:', {
    name: error.name,
    message: error.message,
    statusCode: error.statusCode,
    isOperational: error.isOperational,
  })
  
  // Verifica se é uma instância de AppError (erro operacional esperado)
  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      status: 'error',
      name: error.name,
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  // Verifica erros específicos do Fastify
  if (error.statusCode && error.statusCode >= 400 && error.statusCode < 500) {
    return reply.status(error.statusCode).send({
      status: 'error',
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  // Erro inesperado/não operacional - não expõe detalhes internos
  console.error('Erro não operacional:', error.stack)
  return reply.status(500).send({
    status: 'error',
    message: 'Erro interno do servidor. Entre em contato com o suporte.',
    errorId: error.requestId || 'unknown',
  })
})

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