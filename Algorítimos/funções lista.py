# (a) Troca o primeiro elemento com o último elemento da lista.
def troca_primeiro_e_ultimo(lista):
    if lista:
        lista[0], lista[-1] = lista[-1], lista[0]

# (b) Mova todos os elementos uma posição à frente e o último elemento se torne o primeiro.
def mova_elementos_para_frente(lista):
    if lista:
        ultimo_elemento = lista.pop()
        lista.insert(0, ultimo_elemento)

# (c) Substitua todos os elementos com valores pares por zero.
def substitua_pares_por_zero(lista):
    for i in range(len(lista)):
        if lista[i] % 2 == 0:
            lista[i] = 0

# (d) Substitua todos os elementos em posições pares da lista por zero.
def substitua_pares_posicoes_por_zero(lista):
    for i in range(len(lista)):
        if i % 2 == 0:
            lista[i] = 0

# (e) Retorne True se a lista estiver ordenada em ordem crescente.
def esta_ordenada(lista):
    return all(lista[i] <= lista[i + 1] for i in range(len(lista) - 1))

# Chamadas de teste
lista_a = [1, 2, 3, 4, 5]
troca_primeiro_e_ultimo(lista_a)
print("(a) Troca o primeiro e o último elemento:", lista_a)

lista_b = [1, 4, 9, 16, 25]
mova_elementos_para_frente(lista_b)
print("(b) Move todos os elementos uma posição à frente:", lista_b)

lista_c = [1, 2, 3, 4, 5, 6]
substitua_pares_por_zero(lista_c)
print("(c) Substitui valores pares por zero:", lista_c)

lista_d = [1, 2, 3, 4, 5, 6]
substitua_pares_posicoes_por_zero(lista_d)
print("(d) Substitui elementos em posições pares por zero:", lista_d)

lista_e = [1, 2, 3, 4, 5, 6]
ordenada = esta_ordenada(lista_e)
print("(e) A lista está ordenada em ordem crescente:", ordenada)
