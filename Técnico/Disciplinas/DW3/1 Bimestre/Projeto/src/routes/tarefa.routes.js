
import { listarTarefas, criarTarefa, obterTarefa, atualizarTarefa, concluirTarefa, removerTarefa, resumoTarefas } from '../controllers/tarefa.controller.js'

export async function tarefaRoutes(server) {
    // R: Ler todas as tarefas (com filtro opcional usando Query String)
    server.get('/', async (request, reply) => {
        console.log('Rota GET /tarefas chamada');
        return listarTarefas(request, reply)
    })

    server.post('/', async (request, reply) => {
        console.log('Rota POST /tarefas chamada');
        return criarTarefa(request, reply)
    })

    // R: Ler uma tarefa específica (READ)
    server.get('/:id', async (request, reply) => {
        console.log('Rota GET /tarefas/:id chamada');
        return obterTarefa(request, reply)
    })

    // U: Atualizar uma tarefa parcialmente (UPDATE - PATCH)
    server.patch('/:id', async (request, reply) => {
        console.log('Rota PATCH /tarefas/:id chamada');
        return atualizarTarefa(request, reply)
    })

    // Exercício 2: Rota de "Toggle" Concluir (PATCH)
    server.patch('/:id/concluir', async (request, reply) => {
        console.log('Rota PATCH /tarefas/:id/concluir chamada');
        return concluirTarefa(request, reply)
    })

    // D: Deletar uma tarefa (DELETE)
    server.delete('/:id', async (request, reply) => {
        console.log('Rota DELETE /tarefas/:id chamada');
        return removerTarefa(request, reply)
    })

    // Exercício 4: Rota de Estatísticas/Resumo (GET)
    server.get('/resumo', async (request, reply) => {
        console.log('Rota GET /tarefas/resumo chamada');
        return resumoTarefas(request, reply)
    })
}