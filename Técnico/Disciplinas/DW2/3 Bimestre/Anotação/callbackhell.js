function buscarUsuario(callback) {
    setTimeout(() => {
      console.log('Usuário encontrado');
      callback();
    }, 1000);
  }
  
  function buscarPerfil(callback) {
    setTimeout(() => {
      console.log('Perfil do usuário encontrado');
      callback();
    }, 1000);
  }
  
  function exibirMensagem(callback) {
    setTimeout(() => {
      console.log('Bem-vindo ao sistema!');
      callback();
    }, 1000);
  }
  
  buscarUsuario(() => {
    buscarPerfil(() => {
      exibirMensagem(() => {
        console.log('Processo concluído');
      });
    });
  });

  // O problema do "callback hell" ocorre quando temos múltiplas operações assíncronas dependentes que se aninham, resultando em código difícil de ler e manter.
  // Neste exemplo, cada função assíncrona espera a anterior ser concluída antes de iniciar. O código resultante é difícil de ler e entender, especialmente à medida que mais operações são adicionadas.
  // As promises podem facilmente resolver esse problema, permitindo um código mais legível e gerenciavel. Em vez de passar callbacks, as Promises fornecem métodos (`.then`, `.catch`, `.finally` que se) para lidar com resultados assíncronos de forma encadeada. A resolução a seguir ilusta isso:

  function buscarUsuario() {
    return new Promise((resolve) => {
      setTimeout(() => {
        console.log('Usuário encontrado');
        resolve();
      }, 1000);
    });
  }
  
  function buscarPerfil() {
    return new Promise((resolve) => {
      setTimeout(() => {
        console.log('Perfil do usuário encontrado');
        resolve();
      }, 1000);
    });
  }
  
  function exibirMensagem() {
    return new Promise((resolve) => {
      setTimeout(() => {
        console.log('Bem-vindo ao sistema!');
        resolve();
      }, 1000);
    });
  }
  
  buscarUsuario()
    .then(buscarPerfil)
    .then(exibirMensagem)
    .then(() => {
      console.log('Processo concluído');
    });  