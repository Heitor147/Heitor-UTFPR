function saudacao(nome, callback) {
    console.log('Olá, ' + nome + '!');
    callback();
  }
  
  function mensagemDeDespedida() {
    console.log('Até logo!');
  }
  
  function mensagemDeBoasVindas() {
    console.log('Seja bem vindo(a)!');
  }
  
  saudacao('Joao', mensagemDeBoasVindas);
  saudacao('Maria', mensagemDeDespedida);
  // Olá, João!
  // Seja bem vindo(a)!
  // Olá, Maria!
  // Até logo!