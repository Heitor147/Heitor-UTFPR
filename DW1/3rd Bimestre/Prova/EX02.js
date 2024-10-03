function menorDeTres(a, b, c) {
    let menor = a;
    if (b < menor) {
        menor = b;
    }
    if (c < menor) {
        menor = c;
    }
    return menor;
}

console.log(menorDeTres(5, 3, 8)); // 3
console.log(menorDeTres(10, 20, 15)); // 10
console.log(menorDeTres(7, 7, 7)); // 7
