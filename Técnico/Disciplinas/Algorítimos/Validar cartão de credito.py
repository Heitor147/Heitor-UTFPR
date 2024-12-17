def verifica_cartao(cartao_de_credito):
    if len(cartao_de_credito) == 16:
        return True
    else:
        return False

cartao_digitado = input("Digite o número do cartão: ")
valido = verifica_cartao(cartao_digitado)

if valido:
    print("Seu cartão é válido")
else:
    print("Seu cartão é inválido")