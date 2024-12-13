cidades = ["Curitiba", "Londrina", "Maringá", "Cascavel", "Ponta Grossa"]
distancias = [
    [0, 383, 426, 498, 116],
    [385, 0, 102, 374, 272],
    [427, 102, 0, 273, 315],
    [499, 374, 273, 0, 408],
    [117, 272, 314, 408, 0]
]

while True:

    cidade1 = input("Digite o nome de uma cidade: ")
    cidade2 = input("Digite o nome de outra cidade: ")

    if cidade1 == cidade2:
        print("Você digitou a mesma cidade duas vezes!")
        break

    if cidade1 in cidades and cidade2 in cidades:

        indice_cidade1 = cidades.index(cidade1)
        indice_cidade2 = cidades.index(cidade2)

        distancia = distancias[indice_cidade1][indice_cidade2]
        print(f"A distância entre {cidade1} e {cidade2} é de {distancia} km.")
        
    else:
        print("Uma ou ambas cidades não foram encontradas na lista.")