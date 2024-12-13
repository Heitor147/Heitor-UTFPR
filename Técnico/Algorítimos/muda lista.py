def elementos_unicos(lista):
    lista_unicos = []
    for elemento in lista:
        if elemento not in lista_unicos:
            lista_unicos.append(elemento)
    return lista_unicos

entrada = [1, 2, 3, 3, 3, 3, 4, 5]
saida = elementos_unicos(entrada)
print(saida)
