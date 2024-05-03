localidade = input("Digite sua localidade: ")

while localidade == "Curitiba":
    metros_cubicos = int(input("Digite aqui quantos metros cúbicos de água você usou: "))

    if metros_cubicos <= 0:
        print("Valor inválido!")
    elif metros_cubicos <= 5:
        valor_agua = 90.60
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 10:
        valor_agua = 90.60 + (metros_cubicos - 5) * 2.79
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 15:
        valor_agua = 90.60 + 5 * 2.79 + (metros_cubicos - 10) * 15.62
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 20:
        valor_agua = 90.60 + 5 * 2.79 + 5 * 15.62 + (metros_cubicos - 15) * 15.70
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 30:
        valor_agua = 90.60 + 5 * 2.79 + 5 * 15.62 + 5 * 15.70 + (metros_cubicos - 20) * 15.83
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    else:
        valor_agua = 90.60 + 5 * 2.79 + 5 * 15.62 + 5 * 15.70 + 10 * 15.83 + (metros_cubicos - 30) * 26.78
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break

while localidade != "Curitiba":
    metros_cubicos = int(input("Digite aqui quantos metros cúbicos de água você usou: "))

    if metros_cubicos <= 0:
        print("Valor inválido!")
    elif metros_cubicos <= 5:
        valor_agua = 88.16
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 10:
        valor_agua = 88.16 + (metros_cubicos - 5) * 2.73
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 15:
        valor_agua = 88.16 + 5 * 2.73 + (metros_cubicos - 10) * 15.19
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 20:
        valor_agua = 88.16 + 5 * 2.73 + 5 * 15.19 + (metros_cubicos - 15) * 15.27
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    elif metros_cubicos <= 30:
        valor_agua = 88.16 + 5 * 2.73 + 5 * 15.19 + 5 * 15.27 + (metros_cubicos - 20) * 15.39
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
    else:
        valor_agua = 88.16 + 5 * 2.73 + 5 * 15.19 + 5 * 15.27 + 10 * 15.39 + (metros_cubicos - 30) * 26.05
        print(f"Valor da água: R$ {valor_agua:.2f}")
        break
