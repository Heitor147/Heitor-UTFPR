from decimal import Decimal

gravidade_terra = Decimal('9.8')
metade = Decimal('0.5')

def queda_livre(tempo):
    tempo_decimal = Decimal(str(tempo))  # Convertendo tempo para Decimal
    altura = metade * gravidade_terra * tempo_decimal ** 2
    velocidade = gravidade_terra * tempo_decimal
    return altura, velocidade

def main():
    while True:
        print("Escolha uma opção:")
        print("1 - MRU")
        print("2 - MRUV")
        print("3 - Queda Livre")
        print("0 - Sair")

        escolha_conta = input("Qual cálculo você quer fazer? ")

        if escolha_conta == '0':
            print("Saindo...")
            break

        if escolha_conta == '3':
            tempo = float(input("Escolha o tempo em segundos: "))
            resultado_altura, resultado_velocidade = queda_livre(tempo)
            print("Resultado altura:", resultado_altura)
            print("Resultado velocidade:", resultado_velocidade)

        else:
            print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    main()
