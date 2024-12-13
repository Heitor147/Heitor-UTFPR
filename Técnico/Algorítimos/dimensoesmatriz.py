def main():
    '''
    Programa que lê uma matriz de inteiros com m linhas e n colunas
    e imprime o número de linhas e colunas nulas da matriz.
    '''
    m = int(input("Informe o número de linhas da matriz: "))
    n = int(input("Informe o número de colunas da matriz: "))

    # Inicialize a matriz com zeros
    matriz = []
    for i in range(m):
        linha = []
        for j in range(n):
            elemento = int(input(f"Informe o elemento da posição ({i+1},{j+1}): "))
            linha.append(elemento)
        matriz.append(linha)

    print("Matriz:", m, "x", n)
    for i in range(m):
        for j in range(n):
            print(f"{matriz[i][j]:5}", end=" ")
        print()

    # Contagem de linhas nulas
    linhas_nulas = 0
    for i in range(m):
        if all(element == 0 for element in matriz[i]):
            linhas_nulas += 1

    colunas_nulas = 0
    for j in range(n):
        if all(matriz[i][j] == 0 for i in range(m)):
            colunas_nulas += 1

    print("Linhas nulas =", linhas_nulas)
    print("Colunas nulas =", colunas_nulas)

if __name__ == "__main__":
    main()