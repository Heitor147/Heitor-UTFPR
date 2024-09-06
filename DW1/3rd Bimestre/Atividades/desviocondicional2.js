function fluxo() {

    console.log("1");

    console.log("2");

    if (condicao1()) {
        console.log("A");
    } else {
        if (condicao2()) {
            if (condicao3()) {
                console.log("B");
            } else {
                console.log("C");
            }
        } else {
            console.log("D");
        }
    }

    console.log("3");

    console.log("4");
}

function condicao1() {
    return Math.random() > 0.5; 
}

function condicao2() {
    return Math.random() > 0.5;
}

function condicao3() {
    return Math.random() > 0.5; 
}

fluxo();