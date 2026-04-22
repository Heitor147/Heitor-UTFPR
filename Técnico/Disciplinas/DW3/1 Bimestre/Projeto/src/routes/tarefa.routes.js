
import controller from '../controllers/tarefa.controller.js'

export async function tarefaRoutes(server) {
    // R: Ler todas as tarefas (com filtro opcional usando Query String)
    server.get('/', async (request, reply) => {
        console.log('Rota GET /tarefas chamada');
        return controller.listarTarefas(request, reply)
    })

    server.post('/', async (request, reply) => {
        console.log('Rota POST /tarefas chamada');
        return controller.criarTarefa(request, reply)
    })

    // Exercício 4: Rota de Estatísticas/Resumo (GET) — colocada antes das rotas dinâmicas
    server.get('/resumo', async (request, reply) => {
        console.log('Rota GET /tarefas/resumo chamada');
        return controller.resumoTarefas(request, reply)
    })

    // Nova rota: listar tarefas pendentes — deve ficar antes da rota dinâmica '/:id'
    server.get('/pendentes', async (request, reply) => {
        console.log('Rota GET /tarefas/pendentes chamada');
        return controller.listarTarefasPendentes(request, reply)
    })

    // R: Ler uma tarefa específica (READ)
    server.get('/:id', async (request, reply) => {
        console.log('Rota GET /tarefas/:id chamada');
        return controller.obterTarefa(request, reply)
    })

    // U: Atualizar uma tarefa parcialmente (UPDATE - PATCH)
    server.patch('/:id', async (request, reply) => {
        console.log('Rota PATCH /tarefas/:id chamada');
        return controller.atualizarTarefa(request, reply)
    })

    // Exercício 2: Rota de "Toggle" Concluir (PATCH)
    server.patch('/:id/concluir', async (request, reply) => {
        console.log('Rota PATCH /tarefas/:id/concluir chamada');
        return controller.concluirTarefa(request, reply)
    })

    // D: Deletar uma tarefa (DELETE)
    server.delete('/:id', async (request, reply) => {
        console.log('Rota DELETE /tarefas/:id chamada');
        return controller.removerTarefa(request, reply)
    })

    
}