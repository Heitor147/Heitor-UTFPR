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
import pool from './database/pool.js'

const server = Fastify()

// Habilita CORS
server.register(cors, {
  origin: '*',
  methods: ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS']
})

// ========================================
// Composition Root: Dependency Injection
// ========================================
const repository = new TarefaRepository()
const service = new TarefaService(repository)
const controller = new TarefaController(service)

server.register(tarefaRoutes, { prefix: '/tarefas', controller })
server.register(exemplosRoutes, { prefix: '/exemplos' })

// ========================================
// Rotas de laboratório (validação SQL)
// Remover após confirmação do ambiente
// ========================================
server.post('/lab/tarefas', async (request, reply) => {
  const { descricao } = request.body
  const result = await pool.query(
    'INSERT INTO tarefas (descricao, concluido) VALUES ($1, $2) RETURNING *',
    [descricao, false]
  )
  return reply.status(201).send(result.rows[0])
})

server.get('/lab/tarefas', async (request, reply) => {
  const result = await pool.query('SELECT * FROM tarefas')
  return reply.send(result.rows)
})

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
  
  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      status: 'error',
      name: error.name,
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  if (error.statusCode && error.statusCode >= 400 && error.statusCode < 500) {
    return reply.status(error.statusCode).send({
      status: 'error',
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  console.error('Erro não operacional:', error.stack)
  return reply.status(500).send({
    status: 'error',
    message: 'Erro interno do servidor. Entre em contato com o suporte.',
    errorId: error.requestId || 'unknown',
  })
})

server.setNotFoundHandler((request, reply) => {
  reply.code(404).send({
    status: 'error',
    message: 'O recurso solicitado não existe nesta API.',
  })
})

const PORT = 3000

const start = async () => {
  try {
    // Roteiro 12: valida conexão com o pool antes de subir
    await pool.query('SELECT 1')
    console.log('Conexão com o banco de dados estabelecida com sucesso.')

    await server.listen({ port: PORT })
    console.log(`Servidor rodando em http://localhost:${PORT}`)
  } catch (erro) {
    console.error('Falha ao iniciar o servidor:', erro)
    process.exit(1)
  }
}

start()
