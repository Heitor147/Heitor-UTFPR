import os, random

os.system("clear")

VERDE = "\u001B[32m"
AMARELO = "\u001B[33m"
CINZA = "\u001B[37m"
RESET = "\u001B[0m"


print("Termo")

lista = ["AMARA", "CHUVA", "CORSA", "CHINA", "CHUCK", "VECNA", "VENOM", "SATAN", "JESUS", "UTFPR", "CARNE", "DEUSA", "EMILY", "BANDA", "RADAR", "SOLAR", "MAGMA", "GRIFO", "BACIA", "LUNAR"]
palavra_correta = random.choice(lista)
numero_tentativas = 0

matriz = []
for i in range(6):
    linha = ['*', '*', '*', '*', '*', '*']
    matriz.append(linha)

for i in range(6):
    for j in range(5):
        print(f"{CINZA}{matriz[i][j]}", end= " ")
    print(f"{RESET}")

for i in range(6):
    while True:
        tentativa = input("Digite a palavra: ").upper()
        if len(tentativa) == 5:
            break
        else:
            print("A palavra deve ter exatamente 5 letras. Tente novamente.")
            
    tentativa_lista = list(tentativa)

    matriz[i] = tentativa_lista

    for j in range(5):        
        if matriz[i][j] == palavra_correta[j]:
            print(f"{VERDE}{matriz[i][j]}", end= " ")
        elif matriz[i][j] in palavra_correta and matriz[i][j] != palavra_correta[j]:
            print(f"{AMARELO}{matriz[i][j]}", end= " ")
            numero_tentativas += 1
        else:
            print(f"{RESET}{matriz[i][j]}", end= "")
    print(f"{RESET}")

    if(tentativa == palavra_correta):
        print("PARABÉNS VOCÊ CONSEGUIU!!!")
        print(f"{numero_tentativas} tentativas")
        exit()

print(f"VOCÊ PERDEU SEU VAGABUNDO")
print(f"Você gastou todas as suas tentativas, você tentou {numero_tentativas} vezes")