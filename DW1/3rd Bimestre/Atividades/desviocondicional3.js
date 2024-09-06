function fluxoCom8Caminhos() {
    let valor = Math.floor(Math.random() * 100);

    if (valor < 10) {
        console.log("Caminho 1");
    } else if (valor >= 10 && valor < 20) {
        console.log("Caminho 2");
    } else if (valor >= 20 && valor < 30) {
        console.log("Caminho 3");
    } else if (valor >= 30 && valor < 40) {
        console.log("Caminho 4");
    } else if (valor >= 40 && valor < 50) {
        console.log("Caminho 5");
    } else if (valor >= 50 && valor < 60) {
        console.log("Caminho 6");
    } else if (valor >= 60 && valor < 70) {
        console.log("Caminho 7");
    } else {
        console.log("Caminho 8");
    }
}

fluxoCom8Caminhos();