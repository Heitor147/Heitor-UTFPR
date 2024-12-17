function fluxoCom8Caminhos() {
    let valor = Math.floor(Math.random() * 8);

    switch (valor) {
        case 0:
            console.log("Caminho 1");
            break;
        case 1:
            console.log("Caminho 2");
            break;
        case 2:
            console.log("Caminho 3");
            break;
        case 3:
            console.log("Caminho 4");
            break;
        case 4:
            console.log("Caminho 5");
            break;
        case 5:
            console.log("Caminho 6");
            break;
        case 6:
            console.log("Caminho 7");
            break;
        case 7:
            console.log("Caminho 8");
            break;
        default:
            console.log("Valor fora do intervalo esperado");
            break;
    }
}

fluxoCom8Caminhos();