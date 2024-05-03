def contar_palavras(texto):
    palavras = texto.split()

    numero_palavras = len(palavras)

    print(f"O texto contém {numero_palavras} palavras.")

texto = input("Digite um texto: ")
contar_palavras(texto)