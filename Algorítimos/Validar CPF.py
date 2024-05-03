def verifica_CPF(meu_CPF):
    if len(meu_CPF) < 11:
        return False
    else:
        return True

cpf_digitado = input("Digite seu CPF: ")
valido = verifica_CPF(cpf_digitado)

if valido:
    print("CPF válido.")
else:
    print("CPF inválido.")