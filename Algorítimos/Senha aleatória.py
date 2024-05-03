def senha_aleatoria(senha):
    caracter_maiusculo = 'ABCDEFGHIJKMNOLPRQSTUVXYZ'
    caracter_especial = '!?/\|*@#$%¨&*'
    numeros = '1234567890'
    
    senha_maiuscula = None
    senha_com_caracter_especial = None
    senha_numerica = None

    if any(c in caracter_maiusculo for c in senha):
        senha_maiuscula = True
        print("Sua senha tem caracteres maiúsculos")
    else:
        senha_maiuscula = False
        print("Sua senha não contém caracteres maiúsculos")

    if any(c in caracter_especial for c in senha):
        senha_com_caracter_especial = True
        print("Sua senha contém caracteres especiais")
    else:
        senha_com_caracter_especial = False
        print("Sua senha não contém caracteres especiais")

    if any(c in numeros for c in senha):
        senha_numerica = True
        print("Sua senha contém números")
    else:
        senha_numerica = False
        print("Sua senha não contém números")

senha = input("Digite uma senha: ")
senha_aleatoria(senha)