personagens = [
  {"nome": "Dean Winchester",
  "humano": True,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "e joven": True, #Deve ter por volta dos 30 e poucos anos
  "cacador": True,
  "e_do_bem?": True,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biologica": True,
  "familia_adotiva_ou_de_consideracao": True},

  {"nome": "Sam Winchester",
  "humano": True,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "e jovem": True, #4 anos mais novo que Dean
  "cacador": True,
  "e_do_bem?": True,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biológica": True,
  "familia_adotiva_ou_de_consideracao": True},

 {"nome": "Bobby Singer",
  "humano": True,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "e joven": False,
  "cacador": True,
  "e_do_bem?": True,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biologica": True,
  "familia_adotiva_ou_de_consideracao": True},

  {"nome": "Deus/Chuck Shurley",
  "humano": False,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "cacador": False,
  "e_do_bem?": False,
  "esta_morto?": False,
  "cinco_primeiras_temporadas": True, #Só se revela como Deus na 11 temporada.
  "familia_biologica": True, #Arcanjos e Anjos são considerados seus filhos literais
  "familia_adotiva_ou_de_consideracao": True}, #A Escuridão/Amara é sua irmã de consideração

  {"nome": "A Escuridão/Amara",
  "humano": False,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": False,
  "cacador": False,
  "e_do_bem?": True,
  "esta_morto?": False,
  "cinco_primeiras_temporadas": False,
  "familia_biologica": False,
  "familia_adotiva_ou_de_consideracao": True},

  {"nome": "Morte",
  "humano": False,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "cacador": False,
  "e_do_bem?": True,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biologica": False, #Não está claro qual a relação de Morte com as outras entidades primordiais
  "familia_adotiva_ou_de_consideracao": True}, #Os outros Cavaleiros do Apocalipse são irmãos de Morte, não está claro se isso é literal ou simbólico

  {"nome": "O Vazio",
  "humano": False,
  "arcanjo": False,
  "anjo": False,
  "demonio": False,
  "homem": False,
  "cacador": False,
  "e_do_bem?": False,
  "esta_morto?": False,
  "cinco_primeiras_temporadas": False, #Aparece pela primeira vez na 13 temporada quando Castiel morre e acorda no pós-vida dos anjos e demonios, que é onde O Vazio vive e reina supremo
  "familia_biologica": False, #Não está claro qual a relação do Vazio com as outras entidades primordiais
  "familia_adotiva_ou_de_consideracao": False},

 {"nome": "Crowley",
  "humano": False,
  "arcanjo": False,
  "anjo": False,
  "demonio": True,
  "homem": True,
  "cacador": False,
  "e_do_bem?": False,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biologica": True,
  "familia_adotiva_ou_de_consideracao": False},

  {"nome": "Lucifer",
  "humano": False,
  "arcanjo": True,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "cacador": False,
  "e_do_bem?": False,
  "esta_morto?": True,
  "cinco_primeiras_temporadas": True,
  "familia_biologica": True,
  "familia_adotiva_ou_de_consideracao": False},

  {"nome": "Jack Kline",
  "humano": True,
  "arcanjo": True,
  "anjo": False,
  "demonio": False,
  "homem": True,
  "cacador": False, #Já foi, mas ao se tornar o Novo Deus ele abandonou essa função
  "e_do_bem?": True,
  "esta_morto?": False,
  "cinco_primeiras_temporadas": False, #Apresentado na 12 temporada, se torna um personagem regular a partir da 13 temporada.
  "família_biológica": True,
  "família_adotiva_ou_de_consideração": True},

 {"nome": "Castiel",
  "humano": False,
  "arcanjo": False,
  "anjo": True,
  "demonio": False,
  "homem": True,
  "cacador": False,
  "e_do_bem?": True,
  "esta_morto?": False,
  "cinco_primeiras_temporadas": True,
  "famIlia_biolOgica": True,
  "famIlia_adotiva_ou_de_consideracao": True},
]

def IA(característica, resposta):
    if resposta == "s":
        r = True
    else:
        r = False

    putakipariu = []

    for personagem in personagens:
        if personagem[característica] != r:
            putakipariu.append(personagem)
            
    for personagem in putakipariu:
        personagens.remove(personagem)

    if len(personagens) == 1:
        print("Seu personagem é "+personagens[0]["nome"])
        quit()

humanoresposta = input("Seu personagem é humano? (s/n):")
IA("humano", humanoresposta)
arcanjoresposta = input("Seu personagem é arcanjo? (s/n):")
IA("arcanjo", arcanjoresposta)
anjoresposta = input("Seu personagem é anjo? (s/n):")
IA("anjo", anjoresposta)
demonioresposta = input("Seu personagem é demonio? (s/n):")
IA("demonio", demonioresposta)
homemresposta = input("Seu personagem é homem? (s/n):")
IA("homem", homemresposta)
cacadorresposta = input("Seu personagem é um caçador? (s/n):")
IA("cacador", cacadorresposta)
bondaderesposta = input("Seu personagem é do bem? (s/n):")
IA("e_do_bem?", bondaderesposta)
morteresposta = input("Seu personagem está morto? (s/n):")
IA("esta_morto?", morteresposta)
cincotemporadasresposta = input("Seu personagem aparece nas 5 primeiras temporadas? (s/n):")
IA("cinco_primeiras_temporadas", cincotemporadasresposta)
famíliabiológicarespota = input("Seu personagem tem família biológica? (s/n):")
IA("familia_biologica", famíliabiológicaresposta)
famíliadotivaconsideraçãoresposta = input("Seu personagem tem família adotiva ou de consideração? (s/n):")
IA("familia_adotiva_ou_de_consideracao", famíliadotivaconsideraçãoresposta)
