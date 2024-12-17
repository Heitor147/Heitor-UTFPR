notas = [
    [7.5, 8.0, 6.5, 9.0],
    [6.0, 7.5, 8.0, 7.0],
    [8.5, 6.0, 7.0, 8.0],
    [7.0, 7.5, 6.0, 8.5],
    [6.5, 7.0, 7.5, 8.0]
]

menor_notas_por_aluno = []
for i, linha in enumerate(notas):
    menor_nota = min(linha)
    indice_prova = linha.index(menor_nota) + 1 # Adiciona 1 para corresponder à numeração da prova
    menor_notas_por_aluno.append((i + 1, indice_prova))

print("Menor nota por aluno:")
for aluno, prova in menor_notas_por_aluno:
    print(f"Aluno {aluno}: Menor nota na Prova {prova}")

menor_notas_por_prova = {1: None, 2: None, 3: None, 4: None}
for j in range(4):
    notas_na_prova = [linha[j] for linha in notas]
    menor_nota_na_prova = min(notas_na_prova)
    indice_aluno = notas_na_prova.index(menor_nota_na_prova) + 1 # Adiciona 1 para corresponder ao número do aluno
    menor_notas_por_prova[j + 1] = indice_aluno

print("\nAlunos com menor nota em cada prova:")
for prova, aluno in menor_notas_por_prova.items():
    print(f"Prova {prova}: Aluno {aluno}")
