export default async function tarefaRoutes(server, options) {
  const { controller } = options

  // GET: Listar todas as tarefas (com filtros opcionais)
  server.get('/', async (request, reply) => {
    console.log("Routes: GET / chamada")
    return controller.listarTarefas(request, reply)
  })

  // POST: Criar uma nova tarefa
  server.post('/', async (request, reply) => {
    console.log("Routes: POST / chamada")
    return controller.criarTarefa(request, reply)
  })

  // GET: Obter resumo de tarefas (total, concluídas, pendentes)
  server.get('/resumo', async (request, reply) => {
    console.log("Routes: GET /resumo chamada")
    return controller.obterResumo(request, reply)
  })

  // GET: Obter uma tarefa específica
  server.get('/:id', async (request, reply) => {
    console.log("Routes: GET /:id chamada")
    return controller.obterTarefa(request, reply)
  })

  // PATCH: Atualizar uma tarefa
  server.patch('/:id', async (request, reply) => {
    console.log("Routes: PATCH /:id chamada")
    return controller.atualizarTarefa(request, reply)
  })

  // PATCH: Alternar o status de conclusão de uma tarefa
  server.patch('/:id/concluir', async (request, reply) => {
    console.log("Routes: PATCH /:id/concluir chamada")
    return controller.concluirTarefa(request, reply)
  })

  // DELETE: Remover uma tarefa
  server.delete('/:id', async (request, reply) => {
    console.log("Routes: DELETE /:id chamada")
    return controller.removerTarefa(request, reply)
  })
}