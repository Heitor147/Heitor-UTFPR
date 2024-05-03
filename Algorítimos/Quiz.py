import random

filmes = ["X-Men", "Homem de Ferro", "Invocação do Mal", "Mulher-Maravilha"]
fiAno = [2000,2008,2013,2017]
fiPersona = ["Wolverine", "Tony Stark", "Diana Prince"]

series = ["The Boys", "Loki", "Supernatural"]
seAno = [2019,2020,2005]
sePersona = ["Billy Bruto", "Loki", "Sam Winchester"]

tipo = input("Você quer jogar com filmes (F) ou séries (S)? ")

pontos = 0

if tipo == "F":
    posicao = random.randint(0,2)
    titulo = filmes[posicao]
    ano = fiAno[posicao]
    persona = fiPersona[posicao]
else:
    posicao = random.randint(0,2)
    titulo = series[posicao]
    ano = seAno[posicao]
    persona = sePersona[posicao]

print("O título é: " + titulo)

respostaAno = input("De que ano é o título " + titulo)
if respostaAno == str(ano):
    print("Muito bom!")
    pontos += 5
else:
    print("Que pena!")

respostaPersona = input("Quem é o personagem principal? ")
if respostaPersona == persona:
    print("Parabéns!")
    pontos += 5
else:
    print("Não foi dessa vez...")

print("O total foi de " + str(pontos) + " pontos! ")