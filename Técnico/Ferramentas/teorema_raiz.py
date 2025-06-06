import math

def encontrar_divisores(n):
    """Encontra todos os divisores inteiros de um número n."""
    divisores = set()
    for i in range(1, int(math.sqrt(abs(n))) + 1):
        if n % i == 0:
            divisores.add(i)
            divisores.add(-i)
            divisores.add(n // i)
            divisores.add(-(n // i))
    return sorted(list(divisores))

def teorema_raizes_racionais(coeficientes):
    """
    Aplica o Teorema das Raízes Racionais para encontrar candidatos a raízes.

    Args:
        coeficientes (list): Uma lista de inteiros representando os coeficientes
                             do polinômio, do grau mais alto ao termo constante.
                             Ex: para 2x^3 + 3x - 1, a lista seria [2, 0, 3, -1].
                             Certifique-se de incluir zeros para termos ausentes.

    Returns:
        set: Um conjunto de candidatos a raízes racionais (frações).
    """
    if not coeficientes:
        return set()

    termo_constante = coeficientes[-1]
    coeficiente_lider = coeficientes[0]

    # Se o termo constante é 0, 0 é uma raiz e a divisão por x simplifica o problema.
    # Alertamos o usuário e continuamos com o polinômio original para os outros candidatos.
    if termo_constante == 0 and len(coeficientes) > 1:
        print("\nAtenção: O termo constante é zero. x=0 é uma raiz. Considere dividir o polinômio por x e aplicar o teorema ao novo polinômio para encontrar outras raízes.")
        # Para evitar problemas com o teorema (divisores de 0), podemos tratar isso,
        # mas para a finalidade de demonstração, o alerta é suficiente e prosseguimos.
        # Poderíamos adicionar 0 aos candidatos, mas vamos focar nas não-zero agora.

    divisores_termo_constante = encontrar_divisores(termo_constante)
    divisores_coeficiente_lider = encontrar_divisores(coeficiente_lider)

    candidatos_raizes = set()
    # Adiciona 0 como candidato se o termo constante for 0
    if termo_constante == 0:
        candidatos_raizes.add("0/1")

    for p in divisores_termo_constante:
        for q in divisores_coeficiente_lider:
            if q != 0:  # Evita divisão por zero
                candidatos_raizes.add(f"{p}/{q}")

    # Ordena os candidatos avaliando a fração para comparação numérica
    return sorted(list(candidatos_raizes), key=lambda x: eval(x))

def avaliar_polinomio(coeficientes, x_valor):
    """
    Avalia o valor de um polinômio para um dado x.

    Args:
        coeficientes (list): Coeficientes do polinômio, do grau mais alto ao termo constante.
        x_valor (float): O valor de x a ser substituído no polinômio.

    Returns:
        float: O resultado da avaliação do polinômio em x_valor.
    """
    resultado = 0
    grau = len(coeficientes) - 1
    for i, coef in enumerate(coeficientes):
        resultado += coef * (x_valor ** (grau - i))
    return resultado

def main():
    print("--------------------------------------------------")
    print("       Teorema das Raízes Racionais e Teste       ")
    print("--------------------------------------------------")
    print("Este programa irá encontrar os candidatos a raízes racionais")
    print("para um polinômio com coeficientes inteiros e testá-los.")
    print("\nPor favor, insira os coeficientes do polinômio, do grau mais alto ao termo constante.")
    print("Exemplo: para 2x^3 + 3x - 1, insira: 2 0 3 -1 (inclua 0 para termos ausentes)")

    while True:
        try:
            entrada_coeficientes = input("\nDigite os coeficientes separados por espaços: ")
            coeficientes_str = entrada_coeficientes.split()
            coeficientes = [int(c) for c in coeficientes_str]

            if not coeficientes:
                print("Por favor, insira pelo menos um coeficiente.")
                continue

            break
        except ValueError:
            print("Entrada inválida. Por favor, digite apenas números inteiros separados por espaços.")

    print(f"\nPolinômio inserido (coeficientes): {coeficientes}")

    candidatos = teorema_raizes_racionais(coeficientes)

    if not candidatos:
        print("\nNão foi possível gerar candidatos a raízes racionais com os coeficientes fornecidos.")
        return

    print("\n--- Candidatos a raízes racionais (p/q) ---")
    for candidato in candidatos:
        print(f"  {candidato}")

    print("\n--- Testando os candidatos ---")
    raizes_encontradas = []
    # Um pequeno epsilon para lidar com imprecisões de ponto flutuante,
    # embora para frações exatas com `eval` não seja estritamente necessário.
    # Mas é uma boa prática para comparações de floats.
    tolerancia = 1e-9 # 0.000000001

    for candidato_str in candidatos:
        try:
            # avalia a string da fração para obter o valor numérico (float)
            valor_candidato = eval(candidato_str)
            resultado_avaliacao = avaliar_polinomio(coeficientes, valor_candidato)

            # Verifica se o resultado é muito próximo de zero
            if abs(resultado_avaliacao) < tolerancia:
                print(f"  Testando {candidato_str}: P({candidato_str}) = {resultado_avaliacao:.2e} -> É uma raiz!")
                raizes_encontradas.add(candidato_str)
            else:
                print(f"  Testando {candidato_str}: P({candidato_str}) = {resultado_avaliacao:.2f} -> Não é uma raiz.")
        except Exception as e:
            print(f"  Erro ao testar {candidato_str}: {e}")

    if raizes_encontradas:
        print("\n--- Raízes Racionais Encontradas ---")
        for raiz in raizes_encontradas:
            print(f"  {raiz}")
    else:
        print("\nNenhuma raiz racional foi encontrada entre os candidatos.")

    print("\nObservação: Este método encontra apenas raízes racionais. Polinômios podem ter")
    print("raízes irracionais ou complexas que não serão identificadas aqui.")

if __name__ == "__main__":
    main()