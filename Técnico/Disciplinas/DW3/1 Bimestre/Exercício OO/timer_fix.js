class Timer {
  constructor(nome) {
    this.nome = nome
    this.segundos = 0
    this._intervalId = null
  }

  iniciar() {
    // Usando arrow function para preservar o this da instância
    this._intervalId = setInterval(() => {
      this.segundos++
      console.log(`${this.nome}: ${this.segundos}s`)
    }, 1000)

    // Para demonstração, pare após 3 segundos
    setTimeout(() => {
      clearInterval(this._intervalId)
    }, 3500)
  }
}

// Demonstração
const t = new Timer('Cronômetro')
t.iniciar()
