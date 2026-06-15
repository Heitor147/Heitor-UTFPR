import { ValidationError, NotFoundError } from '../shared/errors/AppError.js'

class TarefaService {
  constructor(repository) {
    this.repository = repository
  }

  async listar(opcoes = {}) {
    console.log("Service: listar chamado")
    const { busca, concluido } = opcoes
    let resultado = await this.repository.buscarTodos()

    if (busca) {
      resultado = resultado.filter(t =>
        t.descricao.toLowerCase().includes(busca.toLowerCase())
      )
    }

    if (concluido !== undefined) {
      const concluidoBool = concluido === 'true'
      resultado = resultado.filter(t => t.concluido === concluidoBool)
    }

    return resultado
  }

  async criar(descricao) {
    console.log("Service: criar chamado")
    if (!descricao || typeof descricao !== 'string' || descricao.trim() === '') {
      throw new ValidationError('A descrição da tarefa é obrigatória e deve ser do tipo string')
    }
    const novaTarefa = await this.repository.salvar({ descricao, concluido: false })
    return novaTarefa
  }

  async buscarPorId(id) {
    console.log("Service: buscarPorId chamado")
    const tarefa = await this.repository.buscarPorId(id)
    if (!tarefa) {
      throw new NotFoundError('Tarefa não encontrada')
    }
    return tarefa
  }

  async atualizar(id, dadosAtualizados) {
    console.log("Service: atualizar chamado")
    const tarefaExistente = await this.repository.buscarPorId(id)
    if (!tarefaExistente) {
      throw new NotFoundError('Tarefa não encontrada')
    }
    return this.repository.atualizar(id, dadosAtualizados)
  }

  async alternarConcluido(id) {
    console.log("Service: alternarConcluido chamado")
    const tarefa = await this.repository.buscarPorId(id)
    if (!tarefa) {
      throw new NotFoundError('Tarefa não encontrada')
    }
    return this.repository.atualizar(id, { concluido: !tarefa.concluido })
  }

  async remover(id) {
    console.log("Service: remover chamado")
    const tarefaExistente = await this.repository.buscarPorId(id)
    if (!tarefaExistente) {
      throw new NotFoundError('Tarefa não encontrada')
    }
    return this.repository.remover(id)
  }

  async obterResumo() {
    console.log("Service: obterResumo chamado")
    const todas = await this.repository.buscarTodos()
    const total = todas.length
    const concluidas = todas.filter(t => t.concluido).length
    const pendentes = total - concluidas
    return { total, concluidas, pendentes }
  }
}

export default TarefaService
