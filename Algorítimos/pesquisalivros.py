livros = [
    ["1984", "George Orwell", 1949, ["Ficção científica", "Ficção política"]],
    ["O Ladrão de Raios", "Rick Riordan", 2005, ["Fantasia", "Mitologia grega"]],
    ["Harry Potter e as Relíquias da Morte", "J.K. Rowling", 2007, ["Fantasia"]],
    ["Carrie", "Stephen King", 1974, ["Fantasia", "Terror"]],
    ["Bird Box", "Josh Malerman", 2014, ["Fantasia", "Terror", "Thriller", "Pós-apocalíptico"]]
]

def livros_por_autor(nome_autor):
    livros_autor = []
    for livro in livros:
        if livro[1] == nome_autor:
            livros_autor.append(livro[0])
    return livros_autor

def livros_por_genero(genero):
    livros_genero = []
    for livro in livros:
        if genero in livro[3]:
            livros_genero.append(livro[0])
    return livros_genero

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

nome_autor_pesquisa = input("Digite o nome do autor para pesquisar seus livros: ")
livros_do_autor = livros_por_autor(nome_autor_pesquisa)
print(f"Livros de {nome_autor_pesquisa}: {livros_do_autor}")

genero_pesquisa = input("Digite o gênero para listar os livros desse gênero: ")
livros_do_genero = livros_por_genero(genero_pesquisa)
print(f"Livros do gênero {genero_pesquisa}: {livros_do_genero}")