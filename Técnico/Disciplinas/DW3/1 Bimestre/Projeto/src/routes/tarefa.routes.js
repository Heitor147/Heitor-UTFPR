
import controller from '../controllers/tarefa.controller.js'

export async function tarefaRoutes(server) {
    // R: Ler todas as tarefas (com filtro opcional usando Query String)
    server.get('/', controller.listarTarefas)

    server.post('/', controller.criarTarefa)

    // Exercício 4: Rota de Estatísticas/Resumo (GET) — colocada antes das rotas dinâmicas
    server.get('/resumo', controller.resumoTarefas)

    // Nova rota: listar tarefas pendentes — deve ficar antes da rota dinâmica '/:id'
    server.get('/pendentes', controller.obterPendentes)

    // R: Ler uma tarefa específica (READ)
    server.get('/:id', controller.obterTarefa)

    // U: Atualizar uma tarefa parcialmente (UPDATE - PATCH)
    server.patch('/:id', controller.atualizarTarefa)

    // Exercício 2: Rota de "Toggle" Concluir (PATCH)
    server.patch('/:id/concluir', controller.concluirTarefa)

    // D: Deletar uma tarefa (DELETE)
    server.delete('/:id', controller.removerTarefa)

    
}