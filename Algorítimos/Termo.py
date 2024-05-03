import random

def termo():
    palavras = [
        "viadão",
        "hidrogenocarbonato",
        "omochiladecriança",
        "inglês",
        "homossexualidade",
        "LGTV",
        "LGBTQIA",
        "fruta",
        "magia",
        "LordVoldemort",
        "vaitomanocu",
        "putakipariu",
        "Acre",
        "Brasil",
        "Adele",
        "TaylorSwift",
        "socialismo",
        "sociologia",
        "marxismo",
        "machismo",
        "PTSD",
        "eletricista",
    ]

    palavra_secreta = random.choice(palavras).lower()
    return palavra_secreta

def mostrar_palavra(palavra, letras_corretas):
    palavra_mostrada = ""

    for letra in palavra:
        if letra in letras_corretas:
            palavra_mostrada += letra
        else:
            palavra_mostrada += "_"
    return palavra_mostrada

def play():
    print("Bem-vindo ao Termo da M31")

    palavra_secreta = termo()
    letras_corretas = []
    tentativas = 10

    while(tentativas > 0):
        print("Termo: ", mostrar_palavra(palavra_secreta,letras_corretas))
        palpite = input("Digite sua letra: ").lower()

        if len(palpite) != 1 or not palpite.isalpha():
            print("O Imbecil, é uma letra só de cada vez!")
            continue

        if palpite in letras_corretas:
            print("Parabéns, agora repete essa mesma letra 35 vezes!")
            continue
        
        letras_corretas.append(palpite)

        if palpite in palavra_secreta:
            print("Letra correta, parabéns Albert Einstein!")
        else:
            tentativas -= 1
            print(f"ERRADO! VOCÊ SÓ TEM MAIS {tentativas} CHANCES")

        if palavra_secreta == mostrar_palavra(palavra_secreta, letras_corretas):
            print("Parabéns! Você acertou, a palavra é:", palavra_secreta)
            break

        if tentativas == 0:
            print("Fim do jogo. A palavra era: ", palavra_secreta)

play()