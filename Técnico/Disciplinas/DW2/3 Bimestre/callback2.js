
function obterDados(url, callback) {
    setTimeout(() => {
      const dados = { usuario: 'João', idade: 25 }; // Simulando uma busca de dados
      callback(dados);
    }, 2000); // Simulando uma operação demorada
  }
  
  function mostrarDados(dados) {
    console.log(`Nome: ${dados.usuario}, Idade: ${dados.idade}`);
  }
  
  obterDados('https://api.exemplo.com/dados', mostrarDados);
  // Após 2 segundos, saída:
  // Nome: João, Idade: 25
  
  