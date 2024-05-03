def romano_para_arabico(romano):
    valores_romanos = {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000
    }

    arabico = 0
    anterior = 0

    for numeral in reversed(romano):
        valor = valores_romanos[numeral]
        
        if valor < anterior:
            arabico -= valor
        else:
            arabico += valor

        anterior = valor

    return arabico

numero_romano = input("Digite um número romano: ")
numero_arabico = romano_para_arabico(numero_romano)
print(f"O número romano {numero_romano} é equivalente a {numero_arabico} em números arábicos.")