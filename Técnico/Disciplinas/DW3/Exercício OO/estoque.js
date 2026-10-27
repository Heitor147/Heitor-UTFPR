class Estoque {
  constructor() {
    this.produtos = [];
  }

  cadastrar(nome, quantidade) {
    if (this.produtos.some(p => p.nome === nome)) {
      console.log('Produto já cadastrado.');
      return;
    }
    this.produtos.push({ nome, quantidade });
  }

  entrada(nome, quantidade) {
    const p = this.produtos.find(p => p.nome === nome);
    if (!p) {
      console.log('Produto não encontrado.');
      return;
    }
    p.quantidade += quantidade;
  }

  saida(nome, quantidade) {
    const p = this.produtos.find(p => p.nome === nome);
    if (!p) {
      console.log('Produto não encontrado.');
      return;
    }
    if (p.quantidade - quantidade < 0) {
      console.log('Quantidade insuficiente.');
      return;
    }
    p.quantidade -= quantidade;
  }

  exibir() {
    this.produtos.forEach(p => console.log(`${p.nome}: ${p.quantidade} unidades`));
  }
}

// Instância e demonstração
const estoque = new Estoque();
estoque.cadastrar('Caneta', 20);
estoque.cadastrar('Caderno', 10);
estoque.entrada('Caneta', 10);
estoque.saida('Caderno', 2);
estoque.exibir();
