class Cliente {
  constructor(nome, email) {
    this.nome = nome
    this.email = email
  }

  exibir() {
    return `${this.nome} <${this.email}>`
  }
}

class Pedido {
  constructor(id, cliente) {
    this.id = id
    this.cliente = cliente
    this.itens = []
    this.status = 'aberto'
  }

  adicionarItem(descricao, valor) {
    this.itens.push({ descricao, valor })
  }

  total() {
    return this.itens.reduce((s, it) => s + it.valor, 0)
  }

  fechar() {
    this.status = 'fechado'
  }

  exibir() {
    console.log(`Pedido #${this.id} | Status: ${this.status}`)
    console.log(`Cliente: ${this.cliente.exibir()}`)
    console.log('Itens:')
    this.itens.forEach(it => console.log(`  - ${it.descricao}: R$ ${it.valor.toFixed(2)}`))
    console.log(`Total: R$ ${this.total().toFixed(2)}`)
  }
}

// Demonstração
const cliente = new Cliente('Ana', 'ana@email.com')
const pedido = new Pedido(1, cliente)
pedido.adicionarItem('Teclado', 200)
pedido.adicionarItem('Mouse', 80)
pedido.fechar()
pedido.exibir()
