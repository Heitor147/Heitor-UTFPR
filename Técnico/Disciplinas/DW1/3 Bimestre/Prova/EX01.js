function somaSerie(cont) {
    let soma = 0;
    for (let i = 1; i <= cont; i++) {
        soma += i * (2 * i - 1);
    }
    return soma;
}

console.log(somaSerie(3)); // 22
console.log(somaSerie(4)); // 50
