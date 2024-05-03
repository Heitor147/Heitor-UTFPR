// Solicitar o nome e validar a entrada
var nome = prompt("Digite seu nome: ");
while (!nome.trim()) {
    nome = prompt("Por favor, digite seu nome: ");
}

// Solicitar a idade e validar a entrada
var idade = prompt("Digite sua idade: ");
while (isNaN(idade) || idade <= 0) {
    idade = prompt("Por favor, digite uma idade válida: ");
}

// Converter a idade para um número inteiro
idade = parseInt(idade);

// Exibir as informações usando template literals
console.log(`Seu nome é: ${nome}`);
console.log(`Sua idade é: ${idade}`);
