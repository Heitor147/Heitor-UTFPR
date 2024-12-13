def MAIOR(lista):
    if len(lista) == 0:
        return None

    maior = lista[0]
    
    for elemento in lista:
        if elemento > maior:
            maior = elemento

    return maior

lista = [14, 80, 20, 46, 34, 660]
maior_elemento = MAIOR(lista)
print("O maior elemento da lista é: ", maior_elemento)
