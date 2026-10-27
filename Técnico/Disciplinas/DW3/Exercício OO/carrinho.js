class Carrinho {
  constructor() {
    this.itens = [];
  }

  adicionar(nome, preco, quantidade) {
    this.itens.push({ nome, preco, quantidade });
  }

  remover(nome) {
    const idx = this.itens.findIndex((it) => it.nome === nome);
    if (idx === -1) {
      console.log('Item não encontrado.');
      return;
    }
    this.itens.splice(idx, 1);
  }

  total() {
    return this.itens.reduce((s, it) => s + it.preco * it.quantidade, 0);
  }

  exibir() {
    this.itens.forEach((it) => {
      const linhaTotal = it.preco * it.quantidade;
      console.log(`${it.quantidade}x ${it.nome} — R$ ${linhaTotal.toFixed(2)}`);
    });
    console.log(`Total: R$ ${this.total().toFixed(2)}`);
  }
}

// Exemplo de uso
const carrinho = new Carrinho();
carrinho.adicionar('Arroz', 5.0, 2);    // 2x Arroz — R$ 10.00
carrinho.adicionar('Sabão', 5.5, 1);    // 1x Sabão — R$ 5.50
carrinho.adicionar('Feijão', 4.0, 1);   // item que será removido
carrinho.remover('Feijão');
carrinho.exibir();

module.exports = Carrinho;
