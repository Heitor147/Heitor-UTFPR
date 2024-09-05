function calcularMulta() {
    const velocidadeMaxima = document.getElementById('velocidadeMaxima').value;
    const velocidadeVeiculo = document.getElementById('velocidadeVeiculo').value;
    const resultadoDiv = document.getElementById('resultado');

    // Limpa o resultado anterior
    resultadoDiv.innerHTML = '';

    // Verifica se os campos estão preenchidos
    if (velocidadeMaxima === '' || velocidadeVeiculo === '') {
        resultadoDiv.innerHTML = '<span>Preencha ambos os campos!</span>';
        return;
    }

    // Converte os valores para números
    const max = parseFloat(velocidadeMaxima);
    const veiculo = parseFloat(velocidadeVeiculo);

    // Calcula a porcentagem de excesso
    const excesso = ((veiculo - max) / max) * 100;

    // Determina a multa com base na porcentagem de excesso
    let mensagemMulta = '';
    if (excesso <= 0) {
        mensagemMulta = 'Você está dentro do limite permitido.';
    } else if (excesso <= 20) {
        mensagemMulta = `Você excedeu ${excesso.toFixed(2)}% a velocidade máxima. Sua multa é de R$ 130,16.`;
    } else if (excesso <= 50) {
        mensagemMulta = `Você excedeu ${excesso.toFixed(2)}% a velocidade máxima. Sua multa é de R$ 195,23.`;
    } else {
        mensagemMulta = `Você excedeu ${excesso.toFixed(2)}% a velocidade máxima. Sua multa é de R$ 880,41.`;
    }

    // Exibe o resultado
    resultadoDiv.innerHTML = `<span>${mensagemMulta}</span>`;
}
