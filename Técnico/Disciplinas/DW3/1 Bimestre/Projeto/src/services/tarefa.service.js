class TarefaService {
    constructor(repository) {
        this.repository = repository
    }

    async listar(busca) {
        console.log('Service listar chamado')
        const todasAsTarefas = await this.repository.buscarTodas()
        if (busca) {
            return todasAsTarefas.filter(t => t.descricao.toLowerCase().includes(busca.toLowerCase()))
        }
        return todasAsTarefas
    }

    async listarPendentes() {
        console.log('Service listarPendentes chamado')
        const todasAsTarefas = await this.repository.buscarTodas()
        return todasAsTarefas.filter(t => !t.concluido)
    }

    async criar(descricao) {
        console.log('Service criar chamado')
        const todasAsTarefas = await this.repository.buscarTodas()
        const novoId = todasAsTarefas.length > 0 ? todasAsTarefas[todasAsTarefas.length - 1].id + 1 : 1
        const novaTarefa = { id: novoId, descricao, concluido: false }
        return await this.repository.criar(novaTarefa)
    }

    async buscarPorId(id) {
        console.log('Service buscarPorId chamado')
        return await this.repository.buscarPorId(id)
    }

    async atualizar(id, dados) {
        console.log('Service atualizar chamado')
        return await this.repository.atualizar(id, dados)
    }

    async remover(id) {
        console.log('Service remover chamado')
        return await this.repository.remover(id)
    }

    async alternarConclusao(id, tarefaExistente) {
        console.log('Service alternarConclusao chamado')
        return await this.repository.atualizar(id, { 
            ...tarefaExistente, 
            concluido: !tarefaExistente.concluido 
        })
    }

    async obterResumo() {
        console.log('Service obterResumo chamado')
        const todasAsTarefas = await this.repository.buscarTodas()
        const total = todasAsTarefas.length
        const concluidas = todasAsTarefas.filter(t => t.concluido).length
        const pendentes = total - concluidas
        return { total, concluidas, pendentes }
    }
}

export default TarefaService
