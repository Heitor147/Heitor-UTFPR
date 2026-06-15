# Sistema Avançado de Tratamento de Exceções - Fastify

## 📋 Visão Geral

Este projeto implementa um sistema robusto de tratamento de exceções seguindo os conceitos do **Roteiro 09 Complementar**, com foco em:

- ✅ **Especialização de Erros**: Classes personalizadas para diferentes tipos de falha
- ✅ **Tratamento Centralizado**: Error Handler global com instanceof
- ✅ **Lógica Pura**: Services sem retornos null/undefined
- ✅ **Controllers Limpos**: Focus no happy path
- ✅ **Assincronismo Seguro**: Proper async/await com try/catch

---

## 🏗️ Arquitetura

```
src/
├── shared/                           # Código compartilhado
│   └── errors/
│       └── AppError.js              # Classes de erro personalizadas
├── features/
│   ├── tarefas/                     # Feature de tarefas
│   │   ├── tarefa.controller.js
│   │   ├── tarefa.service.js       # ⭐ Refatorado com exceções
│   │   └── tarefa.routes.js
│   └── exemplos/                    # 🆕 Feature com funções de exemplo
│       ├── exemplos.controller.js
│       ├── exemplos.service.js      # Divisão, Cadastro, Busca
│       └── exemplos.routes.js
├── repositories/
│   └── tarefa.repository.js
├── server.js                        # ⭐ Error Handler com instanceof
└── ...
```

---

## 🔧 Componentes Implementados

### 1. **Classes de Erro Personalizadas** 
📁 `src/shared/errors/AppError.js`

```javascript
export class AppError extends Error {
  constructor(message, statusCode = 500) {
    super(message)
    this.statusCode = statusCode
    this.isOperational = true
  }
}

// Especializações:
export class ValidationError extends AppError      // Status 400
export class NotFoundError extends AppError        // Status 404
export class ConflictError extends AppError        // Status 409
export class UnauthorizedError extends AppError    // Status 401
export class ForbiddenError extends AppError       // Status 403
```

**Características:**
- ✅ Herdam de `Error` nativa
- ✅ Propriedade `isOperational = true` marca erros esperados
- ✅ `statusCode` específico para cada tipo
- ✅ Named exports para injeção de dependência

---

### 2. **Service Refatorado com Exceções**
📁 `src/services/tarefa.service.js`

**Antes:**
```javascript
async buscarPorId(id) {
  const tarefa = await this.repository.buscarPorId(id)
  if (!tarefa) return null  // ❌ Retorna null
  return tarefa
}
```

**Depois:**
```javascript
async buscarPorId(id) {
  const tarefa = await this.repository.buscarPorId(id)
  if (!tarefa) {
    throw new NotFoundError('Tarefa não encontrada')  // ✅ Lança exceção
  }
  return tarefa
}
```

**Padrões aplicados:**
- ✅ `throw new NotFoundError()` para recursos não encontrados (404)
- ✅ `throw new ValidationError()` para validações de entrada (400)
- ✅ Sem retornos `null` ou `undefined`
- ✅ Todas as operações são `async/await`

---

### 3. **Controller Limpo - Happy Path**
📁 `src/controllers/tarefa.controller.js`

**Antes:**
```javascript
async obterTarefa(request, reply) {
  const id = Number(request.params.id)
  const tarefa = await this.service.buscarPorId(id)
  if (!tarefa) {  // ❌ Validação no controller
    return reply.status(404).send({...})
  }
  return reply.send(tarefa)
}
```

**Depois:**
```javascript
async obterTarefa(request, reply) {
  const id = Number(request.params.id)
  const tarefa = await this.service.buscarPorId(id)  // ✅ Somente happy path
  return reply.send(tarefa)
}
```

**Benefícios:**
- ✅ Responsabilidade única
- ✅ Fácil de readear e testar
- ✅ Validações centralizadas no Service

---

### 4. **Error Handler Global com instanceof**
📁 `src/server.js`

```javascript
server.setErrorHandler((error, request, reply) => {
  console.error('Error Handler capturou:', {
    name: error.name,
    message: error.message,
    statusCode: error.statusCode,
    isOperational: error.isOperational,
  })
  
  // ✅ Usa instanceof para detectar AppError
  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      status: 'error',
      name: error.name,
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  // Erros do Fastify
  if (error.statusCode && error.statusCode >= 400 && error.statusCode < 500) {
    return reply.status(error.statusCode).send({
      status: 'error',
      message: error.message,
      statusCode: error.statusCode,
    })
  }

  // ✅ Erros não operacionais retornam 500 genérico
  console.error('Erro não operacional:', error.stack)
  return reply.status(500).send({
    status: 'error',
    message: 'Erro interno do servidor. Entre em contato com o suporte.',
    errorId: error.requestId || 'unknown',
  })
})
```

**Características:**
- ✅ `instanceof AppError` para verificação de tipo
- ✅ Retorna statusCode específico se for AppError
- ✅ Trata erros do Fastify
- ✅ Protege detalhes internos para erros inesperados
- ✅ Log detalhado para debugging

---

## 📚 Funções de Exemplo

### 1. **Divisão Segura**
📁 `src/features/exemplos/exemplos.service.js`

```javascript
export async function divisaoSegura(dividendo, divisor) {
  if (divisor === 0) {
    throw new ValidationError('O divisor não pode ser zero.')
  }
  return dividendo / divisor
}
```

**Teste:**
```bash
GET /exemplos/divisao?dividendo=10&divisor=2      # ✅ 200 OK
GET /exemplos/divisao?dividendo=10&divisor=0      # ❌ 400 ValidationError
```

---

### 2. **Cadastro de Produto com Validação**

```javascript
export async function cadastrarProduto(produto) {
  if (!produto.nome || typeof produto.nome !== 'string') {
    throw new ValidationError('Campo "nome" é obrigatório e deve ser string.')
  }
  if (!produto.preco || produto.preco <= 0) {
    throw new ValidationError('Campo "preco" deve ser número > 0.')
  }
  // ... retorna produto com ID gerado
}
```

**Teste:**
```bash
POST /exemplos/produtos
Body: { "nome": "Notebook", "preco": 2500, "categoria": "Eletrônicos" }
# ✅ 201 Created

POST /exemplos/produtos
Body: { "preco": 2500, "categoria": "Eletrônicos" }
# ❌ 400 ValidationError (falta "nome")
```

---

### 3. **Busca de Usuário em Memória**

```javascript
export async function buscarUsuario(usuarioId) {
  const usuarios = [
    { id: 1, nome: 'Alice Silva', email: 'alice@example.com', ativo: true },
    // ...
  ]
  
  const usuario = usuarios.find(u => u.id === usuarioId)
  
  if (!usuario) {
    throw new NotFoundError(`Usuário com ID ${usuarioId} não encontrado.`)
  }
  
  return usuario
}
```

**Teste:**
```bash
GET /exemplos/usuarios/1          # ✅ 200 OK (Alice)
GET /exemplos/usuarios/999        # ❌ 404 NotFoundError
```

---

### 4. **Atualizar Status com Conflito**

```javascript
export async function atualizarStatusUsuario(usuarioId, ativo) {
  const usuario = await buscarUsuario(usuarioId)  // Pode lançar NotFoundError
  
  if (usuario.ativo === ativo) {
    throw new ConflictError(`Usuário já possui status "${ativo}".`)
  }
  
  usuario.ativo = ativo
  return usuario
}
```

**Teste:**
```bash
PATCH /exemplos/usuarios/1/status
Body: { "ativo": false }         # ✅ 200 OK (já estava ativo)

PATCH /exemplos/usuarios/1/status
Body: { "ativo": false }         # ❌ 409 ConflictError (já está inativo)
```

---

## 🔄 Fluxo de Tratamento de Erro

```
Request
  ↓
Route Handler
  ↓
Controller (async/await)
  ↓
Service (throw new [Error])
  ↓
Error propagates through stack
  ↓
Fastify catches error
  ↓
server.setErrorHandler()
  ├─ instanceof AppError? → return statusCode + message ✅
  ├─ Fastify error? → return statusCode + message ✅
  └─ Unknown error? → return 500 (generic) ✅
  ↓
Response sent to client
```

---

## 📊 Cobertura de Status HTTP

| Status | Tipo | Exemplo |
|--------|------|---------|
| **200** | Success | OK |
| **201** | Created | Produto cadastrado |
| **204** | No Content | Tarefa removida |
| **400** | ValidationError | Descrição vazia |
| **404** | NotFoundError | Usuário não existe |
| **409** | ConflictError | Status já é o mesmo |
| **500** | Erro desconhecido | Bug interno |

---

## ✨ Princípios Aplicados

1. **Single Responsibility Principle (SRP)**
   - Service cuida da lógica de negócio
   - Controller cuida da requisição/resposta
   - Error Handler cuida de erros

2. **Dependency Injection**
   - Composition Root em `server.js`
   - Services injetam Repository
   - Controllers injetam Service

3. **Fail-Fast Pattern**
   - Erros lançados imediatamente
   - Sem continue/null checks
   - Facilita debugging

4. **Named Exports**
   - Melhor clareza
   - Fácil refatoração
   - Evita conflitos de namespace

5. **Async/Await Safety**
   - Error Handler captura rejeições
   - Sem unhandled rejections
   - Stack traces preservados

---

## 🚀 Como Executar

```bash
# Instalar dependências
npm install

# Modo desenvolvimento (watch)
npm run dev

# Modo produção
npm start

# Servidor em http://localhost:3000
```

---

## 📝 Próximos Passos

- [ ] Adicionar logging com winston/pino
- [ ] Implementar rate limiting
- [ ] Adicionar autenticação JWT
- [ ] Criar middleware de validação
- [ ] Testes unitários com Jest
- [ ] Testes de integração

---

**Desenvolvido com ❤️ seguindo boas práticas de Node.js/Fastify**
