p1 = """
     Quantas temporadas a série tem?
          a) 5
          b) 11
          c) 7
          d) 15
"""

p2 = """
     Qual dos personagens a seguir não existe na série?
          a) Dean Winchester
          b) Deus
          c) Tony Stark
          d) Loki
"""

p3 = """
     Qual dos seguintes personagens morreu e não ressucitou?
          a) Dean Winchester
          b) Jack
          c) Bobby Singer
          d) Castiel
"""

p4 = """
     Qual é a bruxa mais poderosa de Supernatural?
          a) Rowena MacLeod
          b) Clea
          c) Wanda Maximoff
          d) Stephen Strange
"""

p5 = """
     Qual é o anjo mais poderoso de Supernatural?
          a) Castiel
          b) Miguel
          c) Jack
          d) Gabriel
"""

p6 = """
     Qual é o demônio mais poderoso de Supernatural?
          a) Abaddon
          b) Crowley
          c) Lucifer
          d) Lilith
"""

p7 = """
     Qual o demônio que menos aparece na série?
          a) Crowley
          b) Abaddon
          c) Alastair
          d) Azazel
"""

p8 = """
     Qual desses personagens não foi o vilão nem o antagonista de nenhuma temporada?
          a) Abaddon
          b) Crowley
          c) Deus
          d) Jack
"""

p9 = """
     Qual desses personagens era um vilão/antagonista e se tornou um herói?
          a) Castiel
          b) Charlie Bradbury
          c) Bobby Singer
          d) Rowena MacLeod
"""

p10 = """
     Qual desses personagens era secundário e se tornou protagonista?
          a) Charlie Bradbury
          b) Rowena MacLeod
          c) Crowley
          d) Benny
"""

p11 = """
     Qual desses deuses não existe em Supernatural?
          a) Odin
          b) Loki
          c) Zeus
          d) Atena
"""

p12 = """
     Qual é o personagem mais poderoso de Supernatural?
          a) Deus
          b) Amara
          c) Morte
          d) Jack (Novo Deus)
"""

p13 = """
     Qual personagem que costumava ser poderoso agora não é mais?
          a) Deus
          b) Castiel
          c) Jack
          d) Rowena MacLeod
"""

p14 = """
     Qual é a raça de monstros mais fortes que existe?
          a) Leviatãs
          b) Vampiros
          c) Kree
          d) Skrulls
"""

p15 = """
     Qual desses personagens tem uma deficiência física?
          a) Charlie Bradbury
          b) Dean Winchester
          c) Bobby Singer
          d) Crowley
"""

p16 = """
     Qual desses personagens é conhecido por ser o único que já voltou do Vazio?
          a) Crowley
          b) Castiel
          c) Metatron
          d) Miguel
"""

p17 = """
     Qual desses personagens poderosos foram facilmente derrotados por humanos?
          a) Crowley
          b) Amara
          c) Deus
          d) Morte
"""

p18 = """
     Qual desses personagens não é um Winchester?
          a) Castiel
          b) John
          c) Dean
          d) Sam
"""

p19 = """
     Qual desses personagens são conhecidos por terem uma tensão sexual constante?
          a) Sam e Eilen
          b) Deam e Castiel
          c) Castiel e Naomi
          d) Crowley e Jack
"""

p20 = """
     Qual desses personagens tiveram um final "feliz"?
          a) Charlie Bradbury, casou-se com uma mulher e construiu uma familha
          b) Castiel, casou com Dean Winchester
          c) Sam Winchester, construiu uma familha
          d) Bobby Singer, se aposentou e morreu em paz
"""

perguntas = {
    p1:'d', p2:'c',
    p3:'c', p4:'a',
    p5:'b', p6:'d',
    p7:'c', p8:'d',
    p9:'d', p10:'c',
    p11:'d', p12:'d',
    p13:'a', p14:'a',
    p15:'c', p16:'b',
    p17:'d', p18:'a',
    p19:'b', p20:'c',
}

def quiz():
    nome = input("Qual é o seu nome? ")
    print("Oi,",nome,"! Vamos começar as perguntas?")

    pontos = 0
    erros = 0

    for i in perguntas:
        print(i)
        resposta = input("Qual a resposta? (a/b/c/d): ")

        if resposta == perguntas[i]:
            print("Certa resposta!")
            pontos += 1
        else:
            print("Que pena, você errou!")
            pontos -= 1
            erros += 1
    print(f"Sua pontuação foi de {pontos}/20!")
    print(f"Você errou {erros}/20!")

quiz()
