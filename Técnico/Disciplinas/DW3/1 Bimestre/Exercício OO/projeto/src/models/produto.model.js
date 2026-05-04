export default class ProdutoModel {
  #produtos = [
    { id: 1, nome: 'Caneca', preco: 25 },
    { id: 2, nome: 'Caderno', preco: 30 },
    { id: 3, nome: 'Caneta', preco: 5 }
  ]

  #proximoId = 4

  findAll() {
    return Promise.resolve(this.#produtos.slice())
  }

  findById(id) {
    const p = this.#produtos.find(x => x.id === id)
    return Promise.resolve(p)
  }

  create(dados) {
    const produto = { id: this.#proximoId++, nome: dados.nome, preco: dados.preco }
    this.#produtos.push(produto)
    return Promise.resolve(produto)
  }

  delete(id) {
    const idx = this.#produtos.findIndex(x => x.id === id)
    if (idx === -1) return Promise.resolve(false)
    this.#produtos.splice(idx, 1)
    return Promise.resolve(true)
  }

  static validar(dados) {
    const erros = []
    if (!dados || typeof dados.nome !== 'string' || dados.nome.trim() === '') {
      erros.push('O campo nome é obrigatório e não pode ser vazio.')
    }
    if (dados == null || typeof dados.preco !== 'number' || Number.isNaN(dados.preco) || dados.preco <= 0) {
      erros.push('O campo preco é obrigatório e deve ser número maior que 0.')
    }
    if (erros.length > 0) return { valido: false, erros }
    return { valido: true }
  }
}
