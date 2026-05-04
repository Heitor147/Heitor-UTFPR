class FilaAtendimento {
  constructor() {
    this._fila = []
    this.contador = 1
  }

  entrar(nome) {
    const senha = this.contador++
    this._fila.push({ senha, nome })
    console.log(`Senha ${senha} gerada para ${nome}.`)
  }

  chamarProximo() {
    if (this._fila.length === 0) {
      console.log('Fila vazia.')
      return null
    }
    const proximo = this._fila.shift()
    console.log(`Chamando senha ${proximo.senha} — ${proximo.nome}`)
    return proximo
  }

  tamanho() {
    return this._fila.length
  }
}

// Demonstração
const fila = new FilaAtendimento()
fila.entrar('Ana')
fila.entrar('Bruno')
fila.entrar('Carla')
fila.chamarProximo()
fila.chamarProximo()
console.log(`Pessoas na fila: ${fila.tamanho()}`)
