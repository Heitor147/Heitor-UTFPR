// Seleção dos elementos de entrada e saída no DOM
let inputCapital = document.getElementById("capital");
let inputTaxa = document.getElementById("taxa");
let inputPeriodo = document.getElementById("periodo");
let divSaida = document.getElementById("saida");
let botaoCalc = document.getElementById("calcular");

// Define o evento de clique do botão para chamar a função de cálculo
botaoCalc.onclick = calcularJuros;

function calcularJuros() {
    // ENTRADA
    let capital = Number(inputCapital.value);  // Converte o valor do capital para número
    let taxa = Number(inputTaxa.value) / 100;  // Converte a taxa para decimal
    let periodo = Number(inputPeriodo.value);  // Converte o período para número

    // PROCESSAMENTO
    let taxaParenteses = 1 + taxa;
    let potencia = Math.pow(taxaParenteses, periodo);
    let montante = capital * potencia;

    // SAÍDA
    divSaida.innerText = montante.toFixed(2);  // Exibe o resultado com duas casas decimais
}
