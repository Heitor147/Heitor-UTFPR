personagens = [
    {"nome": "Dean Winchester",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": True,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": True,
     "branco": True,
     "vivo": False},

    {"nome": "Sam Winchester",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": True,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": True,
     "branco": True,
     "vivo": False},

    {"nome": "Bobby Singer",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": True,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": False,
     "branco": True,
     "vivo": False},

    {"nome": "Rufus Turner",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": True,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": False,
     "branco": False,
     "vivo": False},

    {"nome": "Ellen/Jo Harvelle",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": False,
     "cacador": True,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": True,
     "branco": True,
     "vivo": False},

    {"nome": "Castiel",
     "primordial": False,
     "arcanjo": False,
     "anjo": True,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": False,
     "5_temporadas": True,
     "e_do_bem": True,
     "vivo": True},

    {"nome": "Jack Kline",
     "primordial": False,
     "arcanjo": True,
     "anjo": False,
     "demonio": False,
     "humano": True,
     "homem": True,
     "cacador": True,
     "5_temporadas": False,
     "e_do_bem": True,
     "joven": True,
     "branco": True,
     "vivo": True},

    {"nome": "Crowley",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": True,
     "humano": False,
     "homem": True,
     "cacador": False,
     "5_temporadas": True,
     "e_do_bem": False,
     "jovem": False,
     "branco": True,
     "vivo": False},

    {"nome": "Deus",
     "primordial": True,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": False,
     "homem": True,
     "cacador": False,
     "5_temporadas": True, #Aparece na quarta e na quinta temporada disfarçado como profeta Chuck Shurley, a paritr da 11 temporada é revelado ser Deus
     "e_do_bem": False,
     "jovem": True,
     "branco": True,
     "vivo": True},

    {"nome": "A Escuridão",
     "primordial": True,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": False,
     "homem": False,
     "cacador": False,
     "5_temporadas": False, #Introduzida na 11 temporada como a principal vilã
     "e_do_bem": True,
     "jovem": True,
     "branco": True,
     "vivo": True},

    {"nome": "Morte",
     "primordial": True,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": False,
     "homem": True,
     "cacador": False,
     "5_temporadas": True,
     "e_do_bem": True, #É mais neutro do que bom, mas como preza pela Ordem Natural, já ajudou os protagonistas várias vezes
     "jovem": False,
     "branco": True,
     "vivo": False}, #Morto com a própria foice no final da 10 temporada

    {"nome": "O Vazio",
     "primordial": True,
     "arcanjo": False,
     "anjo": False,
     "demonio": False,
     "humano": False,
     "homem": False,
     "cacador": False,
     "5_temporadas": False,
     "e_do_bem": False,
     "jovem": False,
     "branco": False,
     "vivo": True},

    {"nome": "Lucifer",
     "primordial": False,
     "arcanjo": True,
     "anjo": True,
     "demonio": False,
     "humano": False,
     "homem": True,
     "cacador": False,
     "5_temporadas": True,
     "e_do_bem": False,
     "vivo": False},

    {"nome": "Lilith",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": True,
     "humano": False,
     "homem": False,
     "cacador": False,
     "5_temporadas": True, #Vilã secundária da 3 temporada e a principal viã da 4 temporada
     "e_do_bem": False,
     "vivo": False},

    {"nome": "Jessie Turner",
     "primordial": False,
     "arcanjo": False,
     "anjo": False,
     "demonio": True,
     "humano": True,
     "homem": True,
     "cacador": False,
     "5_temporadas": True,
     "e_do_bem": True,
     "jovem": True,
     "branco": True,
     "vivo": True},
]

jogar = input("Você quer jogar um jogo?: ")

if jogar.lower() == "sim":

    def IA(caracteristica, resposta):
        if resposta.lower() == "sim":
            r = True    
        else:
            r = False
            
        limbo = []

        for personagem in personagens:
            if personagem[caracteristica] != r:
                limbo.append(personagem)

        for personagem in limbo:
            personagens.remove(personagem)

        if len(personagens) == 1:
            print("Seu personagem é "+personagens[0]["nome"])
            quit() #sair do programa quando adivinhou

    primordialResposta = input("Seu personagem é uma entidade primordial? (s/n): ")
    IA("primordial", primordialResposta)
    arcanjoResposta = input("Seu personagem é um arcanjo? (s/n): ")
    IA("arcanjo", arcanjoResposta)
    anjoResposta = input("Seu personagem é um anjo? (s/n): " )
    IA("anjo", anjoResposta)
    demonioResposta = input("Seu personagem é um demônio? (s/n): ")
    IA("demonio", demonioResposta)
    humanoResposta = input("Seu personagem é humano? (s/n): ")
    IA("humano", humanoResposta)
    homemResposta = input("Seu personagem é homem? (s/n): ")
    IA("homem", homemResposta)
    cacadorResposta = input("Seu personagem é um caçador(a)? (s/n): ")
    IA("cacador", cacadorResposta)
    cincotemporadasResposta = input("Seu personagem aparece nas 5 primeiras temporadas? (s/n): ")
    IA("5_temporadas", cincotemporadasResposta)
    bondadeResposta = input("Seu personagem é do bem? (s/n): ")
    IA("e_do_bem", bondadeResposta)
    jovemResposta = input("Seu personagem é jovem? (s/n): ")
    IA("jovem", jovemResposta)
    brancoResposta = input("Seu personagem é branco? (s/n): ")
    IA("branco", brancoResposta)
    vivoResposta = input("Seu personagem está vivo? (s/n): ")
    IA("vivo", vivoResposta)

else:
    print("Então vai tomar no cool")
    quit()
