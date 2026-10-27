/**
 * AppError - Classe base para erros operacionais da aplicação
 * Estende Error nativa e adiciona statusCode para respostas HTTP
 */
export class AppError extends Error {
  constructor(message, statusCode = 500) {
    super(message)
    this.statusCode = statusCode
    this.isOperational = true
    this.name = 'AppError'
  }
}

/**
 * ValidationError - Erro para validações de dados (4xx)
 * Usado quando campos obrigatórios faltam ou tipos são inválidos
 */
export class ValidationError extends AppError {
  constructor(message = 'Falha na validação dos dados') {
    super(message, 400)
    this.name = 'ValidationError'
  }
}

/**
 * NotFoundError - Erro para recursos não encontrados (404)
 * Usado quando um ID ou recurso não existe no banco/memória
 */
export class NotFoundError extends AppError {
  constructor(message = 'Recurso não encontrado') {
    super(message, 404)
    this.name = 'NotFoundError'
  }
}

/**
 * ConflictError - Erro para conflitos de negócio (409)
 * Usado quando há violação de regras de negócio (ex: dupplicata, estado inválido)
 */
export class ConflictError extends AppError {
  constructor(message = 'Operação conflita com estado atual') {
    super(message, 409)
    this.name = 'ConflictError'
  }
}

/**
 * UnauthorizedError - Erro de autenticação (401)
 */
export class UnauthorizedError extends AppError {
  constructor(message = 'Não autorizado') {
    super(message, 401)
    this.name = 'UnauthorizedError'
  }
}

/**
 * ForbiddenError - Erro de autorização (403)
 */
export class ForbiddenError extends AppError {
  constructor(message = 'Acesso proibido') {
    super(message, 403)
    this.name = 'ForbiddenError'
  }
}
