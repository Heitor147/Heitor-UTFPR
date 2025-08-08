const minhaPromise = new Promise((resolve, reject) => {
    // Operação assíncrona
    const sucesso = true;
    
    if (sucesso) {
      resolve("Operação bem-sucedida!");
    } else {
      reject("Ocorreu um erro.");
    }
  });