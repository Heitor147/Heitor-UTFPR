//document.getElementById("buscarCep").addEventListener("click", function () {
function buscarCep() {
    const cep = document.getElementById("cep").value;

    // URL da API ViaCEP
    const url = `https://viacep.com.br/ws/${cep}/json/`;

    // Faz a requisição à API
    fetch(url)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            if (data.erro) {
                alert("CEP não encontrado.");
                document.getElementById("logradouro").value = data.logradouro || "";
                document.getElementById("bairro").value = "";
                document.getElementById("cidade").value = "";
                document.getElementById("estado").value = "";
                return;
            }

            // Preenche os campos com os dados da API
            document.getElementById("logradouro").value = data.logradouro;
            document.getElementById("bairro").value = data.bairro;
            document.getElementById("cidade").value = data.localidade;
            document.getElementById("estado").value = data.uf;
        })
        .catch((error) => {
            console.error(error);
            alert("Erro ao buscar o CEP. Tente novamente mais tarde.");
        });
}
