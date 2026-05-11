class TarefaRepository {
    constructor() {
        this.tarefas = [
            { id: 1, descricao: "Fazer compras", concluido: false },
            { id: 2, descricao: "Lavar o carro", concluido: false },
            { id: 3, descricao: "Estudar Fastify", concluido: true },
            { id: 4, descricao: "Estudar JavaScript", concluido: true }
        ]
    }

    async buscarTodas() {
        return this.tarefas
    }

    async buscarPorId(id) {
        return this.tarefas.find(t => t.id === id) || null
    }

    async criar(novaTarefa) {
        this.tarefas.push(novaTarefa)
        return novaTarefa
    }

    async atualizar(id, dadosAtualizados) {
        const index = this.tarefas.findIndex(t => t.id === id)
        if (index === -1) return null
        this.tarefas[index] = { ...this.tarefas[index], ...dadosAtualizados, id }
        return this.tarefas[index]
    }

    async remover(id) {
        const index = this.tarefas.findIndex(t => t.id === id)
        if (index === -1) return false
        this.tarefas.splice(index, 1)
        return true
    }
}

export default new TarefaRepository()
