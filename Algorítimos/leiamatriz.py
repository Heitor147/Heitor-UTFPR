def leia_matriz():
    n_linhas = int(input("Digite o número de linhas: "))
    n_colunas = int(input("Digite o número de colunas: "))
    
    matriz = []
    
    for i in range(n_linhas):
        linha = []
        print(f"linha {i} = ", end="")
        
        for j in range(n_colunas):
            while True:
                try:
                    elemento = int(input(f"Digite o elemento ({i},{j}): "))
                    linha.append(elemento)
                    break  # Sai do loop quando um valor válido é inserido
                except ValueError:
                    print("Por favor, insira um valor inteiro válido.")
            
        print(f"linha {i} = {linha}")
        matriz.append(linha)
    
    return matriz

# teste
a_mat = leia_matriz()
print(a_mat)