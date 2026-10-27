class Livro {
  constructor(titulo, autor) {
    this.titulo = titulo
    this.autor = autor
    this.disponivel = true
  }

  emprestar() {
    if (!this.disponivel) {
      console.log('Livro indisponível.')
      return
    }
    this.disponivel = false
  }

  devolver() {
    this.disponivel = true
  }

  exibir() {
    return `${this.titulo} — ${this.autor} — ${this.disponivel ? 'Disponível' : 'Indisponível'}`
  }
}

class Biblioteca {
  constructor(nome) {
    this.nome = nome
    this.acervo = []
  }

  adicionar(livro) {
    this.acervo.push(livro)
  }

  buscar(titulo) {
    return this.acervo.find(l => l.titulo === titulo) || null
  }

  emprestar(titulo) {
    const livro = this.buscar(titulo)
    if (!livro) {
      console.log('Livro não encontrado.')
      return
    }
    livro.emprestar()
  }

  devolver(titulo) {
    const livro = this.buscar(titulo)
    if (!livro) return
    livro.devolver()
  }

  exibirAcervo() {
    this.acervo.forEach(l => console.log(l.exibir()))
  }
}

// Demonstração
const bib = new Biblioteca('Municipal')
const l1 = new Livro('O Alquimista', 'Paulo Coelho')
const l2 = new Livro('Dom Casmurro', 'Machado de Assis')
const l3 = new Livro('1984', 'George Orwell')
bib.adicionar(l1)
bib.adicionar(l2)
bib.adicionar(l3)
bib.emprestar('Dom Casmurro')
bib.emprestar('1984')
bib.devolver('1984')
bib.exibirAcervo()
