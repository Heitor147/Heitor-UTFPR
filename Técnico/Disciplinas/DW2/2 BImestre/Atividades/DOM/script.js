function buscarlivro() {
    const isbn = document.getElementById("isbn").value;

    const url = `https://brasilapi.com.br/api/isbn/v1/${isbn}`;

    fetch(url)
        .then((resposta) => {
            return resposta.json();
        })
        .then((data) => {
            if (data.erro) {
                alert("ISBN não encontrado.");
                document.getElementById("titulo").value = data.title || "";
                document.getElementById("autor").value = data.authors || "";
                document.getElementById("editora").value = data.publisher || "";
                document.getElementById("sinopse").value = data.synopsis || "";
                document.getElementById("publicacao").value = data.year || "";
                document.getElementById("formato").value = data.format || "";
                document.getElementById("paginas").value = data.page_count || "";
                document.getElementById("genero").value = data.subjects || "";
                document.getElementById("local").value = data.location || "";
                document.getElementById("provedor").value = data.provider || "";
                return;
            }

            document.getElementById("titulo").value = data.title;
            document.getElementById("autor").value = data.authors;
            document.getElementById("editora").value = data.publisher;
            document.getElementById("sinopse").value = data.synopsis;
            document.getElementById("publicacao").value = data.year;
            document.getElementById("formato").value = data.format;
            document.getElementById("paginas").value = data.page_count;
            document.getElementById("genero").value = data.subjects;
            document.getElementById("local").value = data.location;
            document.getElementById("provedor").value = data.provider;
        })
        .catch((error) => {
            console.error(error);
            alert("Erro ao buscar o ISBN. Tente novamente mais tarde.");
        });
}