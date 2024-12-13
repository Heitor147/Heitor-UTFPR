import os, random

os.system("clear")

VERDE = "\u001B[32m"
AMARELO = "\u001B[33m"
CINZA = "\u001B[37m"
RESET = "\u001B[0m"


print("Termo")

lista = ["AMARA", "CHUVA", "CORSA", "CHINA", "CHUCK", "VECNA", "VENOM", "SATAN", "JESUS", "UTFPR", "CARNE", "DEUSA", "EMILY"]
palavra_correta = random.choice(lista)

matriz = []
for i in range(6):
    linha = ['*', '*', '*', '*', '*', '*']
    matriz.append(linha)

for i in range(6):
    for j in range(5):
        print(f"{CINZA}{matriz[i][j]}", end= " ")
    print(f"{RESET}")

for i in range(6):
    tentativa = input("Digite a palavra: ").upper()
    tentativa_lista = list(tentativa)

    matriz[i] = tentativa_lista

    for j in range(5):        
        if matriz[i][j] == palavra_correta[j]:
            print(f"{VERDE}{matriz[i][j]}", end= " ")
        elif matriz[i][j] in palavra_correta:
            print(f"{AMARELO}{matriz[i][j]}", end= " ")
        else:
            print(f"{RESET}{matriz[i][j]}", end= "")
    print(f"{RESET}")

    if(tentativa == palavra_correta):
        print("PARABÉNS VOCÊ CONSEGUIU!!!")
        exit()

print(f"VOCÊ PERDEU SEU VAGABUNDO")