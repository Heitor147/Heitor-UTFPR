const prompt = require('prompt-sync')();

function calcularPorcentagem(valor, referencia) {
    let contaInicial = valor / referencia;
    let contaFinal = contaInicial * 100;
    return contaFinal;
}

function capitalFuturo(capital, taxa, tempo) {
    let valorFuturo = capital * Math.pow(1 + taxa, tempo);
    return valorFuturo;
}

function calcularJuroSimples(capital, taxa, tempo) {
    let juroSimples = capital * (1 + taxa * tempo);
    return juroSimples;
}

function calcularJuroComposto(capital, taxa, tempo) {
    let juroComposto = capital * Math.pow(1 + taxa, tempo);
    return juroComposto;
}

function calcularMontante(capital, taxa, tempo) {
    let montante = capital * Math.pow(1 + taxa, tempo);
    return montante;
}

function calcularParcela(capital, taxa, numeroParcela) {
    let parcela = (capital * taxa) / (1 - Math.pow(1 + taxa, -numeroParcela));
    return parcela;
}

function main() {
    const prompt = require('prompt-sync')();

    while (true) {
        console.log("Escolha uma opção:");
        console.log("1 - Porcentagem");
        console.log("2 - Capital Futuro");
        console.log("3 - Juro Simples");
        console.log("4 - Juro Composto");
        console.log("5 - Montante");
        console.log("6 - Parcelas");
        console.log("0 - Sair");

        let escolhaConta = prompt("Qual cálculo você quer fazer? ");

        if (escolhaConta === '0') {
            console.log("Saindo...");
            break;
        }

        if (escolhaConta === '1') {
            let valorCalcularPorcentagem = parseFloat(prompt("Insira o valor a ser calculado: "));
            let valorReferenciaPorcentagem = parseFloat(prompt("Insira o valor de referência: "));
            let contaFinal = calcularPorcentagem(valorCalcularPorcentagem, valorReferenciaPorcentagem);
            console.log(`${valorCalcularPorcentagem} equivale a ${contaFinal}%.`);
        }

        if (escolhaConta === '2') {
            let valorCapital = parseFloat(prompt("Insira o valor do capital: "));
            let valorTaxa = parseFloat(prompt("Insira o valor da taxa percentual ao mês: ")) / 100;
            let tempo = parseFloat(prompt("Insira o tempo em meses: "));
            let valorFuturo = capitalFuturo(valorCapital, valorTaxa, tempo);
            console.log(`O valor futuro com juros compostos é ${valorFuturo}.`);
        }

        if (escolhaConta === '3') {
            let valorCapital = parseFloat(prompt("Insira o valor do capital: "));
            let valorTaxa = parseFloat(prompt("Insira o valor da taxa percentual ao mês: ")) / 100;
            let tempo = parseFloat(prompt("Insira o tempo em meses: "));
            let valorJuroSimples = calcularJuroSimples(valorCapital, valorTaxa, tempo);
            console.log(`O valor total com juros simples é ${valorJuroSimples}.`);
        }

        if (escolhaConta === '4') {
            let valorCapital = parseFloat(prompt("Insira o valor do capital: "));
            let valorTaxa = parseFloat(prompt("Insira o valor da taxa percentual ao mês: ")) / 100;
            let tempo = parseFloat(prompt("Insira o tempo em meses: "));
            let valorJuroComposto = calcularJuroComposto(valorCapital, valorTaxa, tempo);
            console.log(`O valor total com juros compostos é ${valorJuroComposto}.`);
        }

        if (escolhaConta === '5') {
            let valorCapital = parseFloat(prompt("Insira o valor do capital: "));
            let valorTaxa = parseFloat(prompt("Insira o valor da taxa percentual ao mês: ")) / 100;
            let tempo = parseFloat(prompt("Insira o tempo em meses: "));
            let valorMontante = calcularMontante(valorCapital, valorTaxa, tempo);
            console.log(`O montante final com juros compostos é ${valorMontante}.`);
        }

        if (escolhaConta === '6') {
            let valorCapital = parseFloat(prompt("Insira o valor do capital: "));
            let valorTaxa = parseFloat(prompt("Insira o valor da taxa percentual ao mês: ")) / 100;
            let valorNumeroParcela = parseInt(prompt("Insira o número de parcelas: "));
            let valorParcela = calcularParcela(valorCapital, valorTaxa, valorNumeroParcela);
            console.log(`O valor das parcelas é ${valorParcela.toFixed(2)}.`);
        } else {
            console.log("Opção Inválida! Tente novamente!");
        }
    }
}

main();