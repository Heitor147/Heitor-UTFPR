def palindromas_na_lista(lista_palavras):
    palindromas = []

    for palavra in lista_palavras:
        if palavra == palavra[::-1]:
            palindromas.append(palavra)

    return palindromas

lista_de_palavras = ["aba", "casa", "radar", "solos", "python", "level"]
palindromas_encontradas = palindromas_na_lista(lista_de_palavras)
print("Palavras palíndromas na lista:", palindromas_encontradas)