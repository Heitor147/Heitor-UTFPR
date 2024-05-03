def calculo_de_metros_em_relacao_ao_tempo(tempo, metros, operacao):
    if operacao == 'Soma':
        resultado_metros = tempo + metros
    elif operacao == 'Subtração':
        resultado_metros = tempo - metros
    elif operacao == 'Multiplicação':
        resultado_metros = tempo * metros
    elif operacao == 'Divisão':
        resultado_metros = tempo / metros
    else:
        raise ValueError("Operação inválida")
    return resultado_metros

def calculo_de_litros_em_relacao_ao_tempo(tempo, litros, operacao):
    if operacao == 'Soma':
        resultado_litros = tempo + litros
    elif operacao == 'Subtração':
        resultado_litros = tempo - litros
    elif operacao == 'Multiplicação':
        resultado_litros = tempo * litros
    elif operacao == 'Divisão':
        resultado_litros = tempo / litros
    else:
        raise ValueError("Operação inválida")
    return resultado_litros

def main():
    while True:

        print("Escolha uma opção:")
        print("1 - Metros")
        print("2 - Litros")
        print("0 - Sair")

        escolha_medida = input("Qual medida você quer usar? ")

        if escolha_medida == '0':
            print("Saindo...")
            break

        print("Escolha uma operação:")
        print("Soma")
        print("Subtração")
        print("Multiplicação")
        print("Divisão")
               
        escolha_operacao = input("Qual operação será usada? ")

        tempo = float(input("Escolha o tempo em minutos: "))

        if escolha_medida == '1':
            metros = float(input("Escolha a quantidade de metros a serem usados: "))
            resultado = calculo_de_metros_em_relacao_ao_tempo(tempo, metros, escolha_operacao)
            print("Resultado:", resultado)
                
        elif escolha_medida == '2':
            litros = float(input("Escolha a quantidade de litros a serem usados: "))
            resultado = calculo_de_litros_em_relacao_ao_tempo(tempo, litros, escolha_operacao)
            print("Resultado:", resultado)
            
        else:
            print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    main()
