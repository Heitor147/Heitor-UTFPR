var nome = document.getElementById("nome").value;
var idade = document.getElementById("idade").value;

if (nome.trim() === "") {
    alert("Por favor, digite seu nome.");
    return;
}

if (isNaN(idade) || idade <= 0) {
    alert("Por favor, digite uma idade válida.");
    return;
}

idade = parseInt(idade);

// Exibir informações na página
document.getElementById("info").innerHTML = `
         <p>Seu nome é ${nome}</p>
         <p>Você tem ${idade} anos</p>
        `;