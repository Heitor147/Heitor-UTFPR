livros = [
    ["1984", "George Orwell", 1949, ["Ficção científica", "Ficção política"]],
    ["O Ladrão de Raios", "Rick Riordan", 2005, ["Fantasia", "Mitologia grega"]],
    ["Harry Potter e as Relíquias da Morte", "J.K. Rowling", 2007, ["Fantasia"]],
    ["Carrie", "Stephen King", 1974, ["Terror"]],
    ["Bird Box", "Josh Malerman", 2014, ["Terror", "Thriller", "Pós-apocalíptico"]]
]

for i in range(2):

    livro = []

    nome_livro = input("Digite o nome do livro: ")
    livro.append(nome_livro)

    autor_livro = input("Digite o nome do autor/autora: ")
    livro.append(autor_livro)

    ano_livro = input("Digite o ano de lançamento do livro: ")
    livro.append(ano_livro)

    genero_livro = input("Informe o gênero do livro: ")
    livro.append(genero_livro)

    livros.append(livro)

    continuar = input("Deseja adicionar mais livros? (s/n): ")
    if continuar.lower() != 's':
        break

print(livros)