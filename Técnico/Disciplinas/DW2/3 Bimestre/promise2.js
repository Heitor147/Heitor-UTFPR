function pedirUber() {
  console.log("Iniciando solicitação");
  console.log("Encontrando motorista");
  let encontrouMotorista = false; // Simulando que não encontrou motorista  

  const promessa = new Promise((resolve, reject) => {
    setTimeout(() => {
      if (encontrouMotorista) resolve("Motorista a caminho");
      else reject(new Error("Não há motoristas disponíveis para sua corrida"));
    }, 2000);
  });
  return promessa;
}

pedirUber()
  .then((resposta) => console.log(resposta))
  .catch((erro) => console.log(erro.message))
  .finally(() => console.log("Solicitação finalizada"));