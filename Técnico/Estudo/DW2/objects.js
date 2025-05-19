// Um objeto em JavaScript é um conjunto de propriedades, em que cada propriedade é uma associação de um nome (chave) e um valor (valor primitivo, como um número ou string, ou um objeto)

var empty = {}; //Cria um objeto vazio
var point = {x:0,y:0}; //Cria um objeto com duas propriedades
var point2 = {x:point.x, y:point.y+1}; //Valores mais complexos
var informacao_pessoal = { //Objeto literal
    "nome": "Heitor",
    "idade": "17",
    "cidade natal": "Campo Mourão", //Nomes das propriedades podem ser separados sem underline (_)
    "cidade-atual": "Engenheiro Beltrão", //Nomes de propriedades podem incluir hífen (-)
    "escola": "UTFPR",
    "teste": "vazio",
    "teste2": "void",
    parentes: {  //Criando um objeto dentro do objeto
        pai: "Ezequiel",
        mae: "Marta"
    }
};

console.log(informacao_pessoal)

var o = new Object() //Faz o mesmo que {}.

//Manipulando Objetos

var parentes = informacao_pessoal.parentes; //Obtém a propriedade "parentes" de "informacao_pessoal"
var mae = parentes.mae; //Obtém a propriedade "mae" de "parentes"
var nome = informacao_pessoal["nome"] //Obtém a propriedade "nome"

informacao_pessoal.profissao = "Estudante"; //Cria uma propriedade "profissao" e adiciona um valor
informacao_pessoal["cidade-atual"] = "Curitiba"; //Configura a propriedade "cidade-atual" e altera seu valor

delete informacao_pessoal.teste; //Agora o objeto "informacao_pessoal" não tem mais a propriedade "teste"
delete informacao_pessoal["teste2"]; //Agora também não tem "teste2"

o = {x:1};
delete o.x; //Exclui x e retorna true
delete o.x; //Não faz nada (x não existe) e retorna true
delete 1; //Não tem sentido, mas é avaliada como true