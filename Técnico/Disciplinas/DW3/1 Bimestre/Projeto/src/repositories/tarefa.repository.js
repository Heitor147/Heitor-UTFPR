import pool from '../database/pool.js'

class TarefaRepository {
  async buscarTodos() {
    console.log('Repository: buscarTodos chamado')
    const result = await pool.query('SELECT * FROM tarefas')
    return result.rows
  }

  async buscarPorId(id) {
    console.log('Repository: buscarPorId chamado')
    const result = await pool.query(
      'SELECT * FROM tarefas WHERE id = $1',
      [id]
    )
    return result.rows[0] ?? null
  }

  async salvar(tarefa) {
    console.log('Repository: salvar chamado')
    const result = await pool.query(
      'INSERT INTO tarefas (descricao, concluido) VALUES ($1, $2) RETURNING *',
      [tarefa.descricao, tarefa.concluido]
    )
    return result.rows[0]
  }

  async atualizar(id, dadosAtualizados) {
    console.log('Repository: atualizar chamado')
    const atual = await this.buscarPorId(id)
    if (!atual) return null

    const dados = { ...atual, ...dadosAtualizados }

    const result = await pool.query(
      'UPDATE tarefas SET descricao = $1, concluido = $2 WHERE id = $3 RETURNING *',
      [dados.descricao, dados.concluido, id]
    )
    return result.rows[0]
  }

  async remover(id) {
    console.log('Repository: remover chamado')
    const result = await pool.query(
      'DELETE FROM tarefas WHERE id = $1',
      [id]
    )
    return result.rowCount > 0
  }
}

export default TarefaRepository
