# Aula 16 do 5

autismo
asfasfasf
aussasfafasfasfsa

## Proprieadade
. ``border``

1. **sanduiches**
2. *autismo*

## Lista Não-Ordenada


## Lista Ordenada
1. Item 1
2. Item 2
3. Item 3

## Trecho de Código aleatório em Python

```python
import random

def gera_lista(n, inicio, fim):
    lista = []
    for _ in range(n):
        numero_aleatorio = random.randint(inicio, fim)
        lista.append(numero_aleatorio)
    return lista

n = int(input("Digite a quantidade de números desejados: "))
inicio = int(input("Digite o valor inicial do intervalo: "))
fim = int(input("Digite o valor final do intervalo: "))

resultado = gera_lista(n, inicio, fim)
print("Lista gerada:", resultado)
```