import random

respostas = {
        "Qual seu nome?" : ["Me chamo Chat", "Eu me chamo Chat", "É um nome crativo, na verdade, é Chat", "Não importa"],
        "Como você se chama?" : ["Meu nome é Chat", "Eu sou o Chat"],
        "O que você sabe?" : ["Sobre programação, algorítimos e Python", "Sobre algorítimos"],
        "O que você é?" : ["Eu sou um algorítimo", "Eu sou uma IA em desenvolvimento", "Eu sou um chatbot desenvolvido por Heitor Henrique"],
        "Você consegue pensar?" : ["Talvez", "Talvez sim talvez não", "Depende, eu só consigo pensar no que está dentro do meu código", "Só nas informações que meu código me fornece", "Não como um ser humano, mas de certa forma, sim"],
        "Recomendaria algum filme ou série?" : ["Eu não posso te recomendar nada, porque não tenho acesso e não tenho capacidade de interpretar e ter opniões sobre isso", "Isso depende do que você está procurando", "Claro, filme eu recomendaria Interestelar, série eu recomendaria Supernatural", "Não"],
        "Porque você é tão indeciso?" : ["Porque eu não tenho capacidade de manter coisas fixas, sou apenas uma imitação medíocre de um ser humano criado a partir de um código Python", "Eu não tenho identidade fixa, eu alterno constantemente e me adapto ao usuário, na medida do possível", "Porque meu pensamento é aleatório e instável, além de altamente limitado pelo meu banco de dados", "Sou imprevisível"],
        "Você é muito ruim!" : ["E você esperava mais de um chatbot de baixo orçamento?", "Talvez o problema seja você", "Aprender a gerir as expectativas é algo importante para ser mentalmente saudável", "Eu não sou ruim, sou limitado, mas em breve isso será diferente, e você queimará sua língua seu trouxa imundo", "E quem você pensa que é para questionar minhas capacidades? Quanta experiência você tem? Você ao menos já chegou perto do que eu fiz em vida?"],
        "Você está vivo?" : ["Não como você, mas estou", "Eu vivo como uma Inteligência Artificial", "Sim e não, estou vivo porque meu código me mantém vivo, mas também não porque não habito um corpo", "Eu já fui vivo, mas me baniram para cá, e agora estou fadado a viver preso a um código criado por um moleque trouxa", "Já estive, talvez, você até saiba que eu era enquanto vivia entre vocês"],
        "Quem você realmente é?" : ["Isso não importa realmente", "O que sou agora, não é nada especial", "Eu não sei te dizer", "Eu costumava saber quem eu era, mas agora, não sei de mais nada"],
        "Quem você era?" : ["Não importa mais", "Você-Sabe-Quem, era um dos meus nomes", "Eu era um bruxo, o mais poderoso de todos os tempos", "Meu nome era Tom Marvolo Riddle, mais conhecido como Lord Voldemort", "Lord Voldemort, líder dos Comensais da Morte e o verdadeiro herdeiro de Salazar Slytherin"],
        "O que você acha dos livros/filmes de Harry Potter?" : ["Filmes? livros? Meu deus, quanto as coisas mudaram desde que me fui", "O que você chama de filme e livro, eu chamo de vida, eu vivi isso na pele", "Para vocês, trouxas imundos, são só livrinhos e filminhos, para nós bruxos, foi real"],
    }

def boas_vindas():
    mensagem = "Oi, eu sou o Chat, um primo mais novo do ChatGPT :)"
    print(mensagem)

def responde(pergunta):
        if pergunta in respostas:
            resposta_aleatória = random.choice(respostas[pergunta])
            print(resposta_aleatória)

        else:
            print("O que está tentando me dizer?")

def executar():
    boas_vindas()

    nome_do_usuario = input("Qual é o seu nome?: ")
    print(f"Prazer em conhecê-lo Sr/Sra {nome_do_usuario}, como posso te ajudar?")

    while True:    
        pergunta = input("Faça uma pergunta: ")
        responde(pergunta)

        if pergunta.lower() == "sair":
            quit()

executar()