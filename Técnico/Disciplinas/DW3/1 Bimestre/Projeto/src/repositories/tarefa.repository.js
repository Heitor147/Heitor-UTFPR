import pool from '../database/pool.js'

// Query base reutilizada nos métodos de leitura.
// LEFT JOIN: retorna a tarefa mesmo quando projeto_id é null.
const SELECT_COM_PROJETO = `
  SELECT t.*, p.nome AS projeto_nome
  FROM tarefas t
  LEFT JOIN projetos p ON t.projeto_id = p.id
`

class TarefaRepository {
  async buscarTodos() {
    console.log('Repository: buscarTodos chamado')
    const result = await pool.query(`${SELECT_COM_PROJETO} ORDER BY t.id`)
    return result.rows
  }

  async buscarPorId(id) {
    console.log('Repository: buscarPorId chamado')
    const result = await pool.query(
      `${SELECT_COM_PROJETO} WHERE t.id = $1`,
      [id]
    )
    return result.rows[0] ?? null
  }

  async buscarPorProjeto(projetoId) {
    console.log('Repository: buscarPorProjeto chamado')
    // INNER JOIN: só retorna tarefas que de fato pertencem ao projeto.
    const result = await pool.query(
      `SELECT t.*, p.nome AS projeto_nome
       FROM tarefas t
       INNER JOIN projetos p ON t.projeto_id = p.id
       WHERE t.projeto_id = $1
       ORDER BY t.id`,
      [projetoId]
    )
    return result.rows
  }

  async salvar(tarefa) {
    console.log('Repository: salvar chamado')
    const result = await pool.query(
      `INSERT INTO tarefas (descricao, concluido, projeto_id)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [tarefa.descricao, tarefa.concluido, tarefa.projetoId ?? null]
    )
    return result.rows[0]
  }

  async atualizar(id, dadosAtualizados) {
    console.log('Repository: atualizar chamado')
    const atual = await this.buscarPorId(id)
    if (!atual) return null

    const dados = { ...atual, ...dadosAtualizados }

    const result = await pool.query(
      `UPDATE tarefas
       SET descricao = $1, concluido = $2
       WHERE id = $3
       RETURNING *`,
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
