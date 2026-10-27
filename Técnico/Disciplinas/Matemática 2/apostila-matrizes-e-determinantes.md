# Matrizes e Determinantes

## Introdução

### O que é isso, afinal?

Uma **matriz** é uma tabela de números organizada em linhas e colunas. Só isso. Se você já abriu uma planilha, já lidou com uma matriz. O que torna o assunto interessante é que existem regras para somar, multiplicar e "desfazer" essas tabelas, e essas regras resolvem problemas que parecem não ter nada a ver com tabelas: sistemas de equações, rotação de imagens, criptografia, ranking do Google, gráficos de videogame.

O **determinante** é um número único que você extrai de uma matriz quadrada (mesmo número de linhas e colunas). Ele funciona como um "RG" da matriz: com ele você descobre se a matriz tem inversa, se um sistema de equações tem solução única e quanto uma transformação geométrica estica ou encolhe áreas.

### Pré-requisitos

Saber somar, subtrair, multiplicar e lidar com números negativos. Só. Se você já resolveu um sistema de duas equações com duas incógnitas, melhor ainda, mas não é obrigatório.

### O que esta apostila cobre

1. O que é uma matriz e como se escreve
2. Tipos de matrizes
3. Operações (soma, multiplicação por número, multiplicação entre matrizes, transposta)
4. Determinantes: ordem 1, 2 e 3 (Sarrus), ordem maior (Laplace), propriedades
5. Matriz inversa
6. Aplicações (sistemas lineares, geometria, criptografia, redes)
7. Exercícios com gabarito e erros comuns

Fica de fora: autovalores, diagonalização e espaços vetoriais. Isso é Álgebra Linear de faculdade, e esta apostila te deixa pronto pra entrar nela.

### Convenções de notação

Usei vírgula como separador decimal (padrão brasileiro). Dentro das matrizes, quando precisei de número não inteiro, escrevi fração pra não confundir a vírgula decimal com o separador de elementos. Potência de matriz vai como `A²`, transposta como `Aᵀ`, inversa como `A⁻¹`.

---

## Parte 1: Fundamentos

### 1.1 Anatomia de uma matriz

Uma matriz com **m linhas** e **n colunas** é dita de **ordem m × n** (lê-se "m por n"). A linha vem sempre primeiro.

```
        col1 col2 col3
linha1 [  1    2    3  ]
linha2 [  4    5    6  ]
```

Essa matriz é 2 × 3. Cada número dentro dela é um **elemento**. Para localizar um elemento usamos dois índices: `aᵢⱼ` é o elemento da **linha i** e **coluna j**. Na matriz acima:

- a₁₁ = 1 (linha 1, coluna 1)
- a₁₃ = 3 (linha 1, coluna 3)
- a₂₂ = 5 (linha 2, coluna 2)

Uma forma de nunca errar a ordem dos índices: **primeiro desce, depois anda pro lado** (linha, depois coluna). Ou pense em "Linha Colunha" como um jeito bobo de lembrar que L vem antes de C no alfabeto.

A matriz inteira costuma ser escrita entre colchetes ou parênteses, e recebe nome em letra maiúscula: **A**, **B**, **M**. Notação compacta: `A = (aᵢⱼ)ₘₓₙ`.

### 1.2 Exemplos de matrizes no mundo real

**Convencional:** notas de três alunos em duas provas.

```
           P1   P2
Ana     [  8    7  ]
Bruno   [  5    9  ]
Carla   [ 10    6  ]
```

Matriz 3 × 2. O elemento a₂₂ = 9 diz que Bruno tirou 9 na segunda prova.

**Inusitado:** uma imagem em tons de cinza. Cada pixel é um número de 0 (preto) a 255 (branco), e a foto inteira é uma matriz. Uma imagem de 1080 × 1920 pixels é literalmente uma matriz com 1080 linhas e 1920 colunas. Quando você aplica um filtro no celular, o app está fazendo operações com matrizes.

```
[  0   128  255 ]
[ 64   200   30 ]
[255     0  100 ]
```

Matriz 3 × 3 que seria uma imagem minúscula de 9 pixels.

### 1.3 Lei de formação

Às vezes a matriz não vem com os números prontos. Em vez disso, dão uma **regra** para calcular cada elemento a partir dos índices.

**Exemplo 1.** Construa A = (aᵢⱼ) de ordem 3 × 3 com aᵢⱼ = i + j.

Passo a passo: calcule elemento por elemento.

- Linha 1: a₁₁ = 1+1 = 2, a₁₂ = 1+2 = 3, a₁₃ = 1+3 = 4
- Linha 2: a₂₁ = 3, a₂₂ = 4, a₂₃ = 5
- Linha 3: a₃₁ = 4, a₃₂ = 5, a₃₃ = 6

```
A = [ 2  3  4 ]
    [ 3  4  5 ]
    [ 4  5  6 ]
```

**Exemplo 2.** Construa B de ordem 2 × 2 com bᵢⱼ = i² − j.

- b₁₁ = 1² − 1 = 0
- b₁₂ = 1² − 2 = −1
- b₂₁ = 2² − 1 = 3
- b₂₂ = 2² − 2 = 2

```
B = [ 0  -1 ]
    [ 3   2 ]
```

**Exemplo 3 (regra com condição).** cᵢⱼ = 1 se i = j, e 0 se i ≠ j. Para ordem 3 × 3, isso gera a matriz identidade (que você vai conhecer logo abaixo).

### 1.4 Igualdade de matrizes

Duas matrizes são iguais quando têm **a mesma ordem** e **todos os elementos correspondentes iguais**. Isso vira uma ferramenta pra achar incógnitas:

```
[ x+1   4 ]   [ 5   y-2 ]
[  3    z ] = [ 3    7  ]
```

Comparando posição por posição: x + 1 = 5 (logo x = 4), 4 = y − 2 (logo y = 6), z = 7.

---

## Parte 2: Tipos de matrizes

Saber os nomes importa porque as provas (e os livros) usam eles como se fossem óbvios.

| Tipo | Como reconhecer | Exemplo |
|---|---|---|
| **Linha** | Só 1 linha (1 × n) | `[ 3  7  1 ]` |
| **Coluna** | Só 1 coluna (m × 1) | `[ 2 ; 9 ; 4 ]` (em pé) |
| **Nula** | Todos os elementos são 0 | `[ 0 0 ; 0 0 ]` |
| **Quadrada** | m = n | qualquer 2×2, 3×3... |
| **Diagonal** | Quadrada, zeros fora da diagonal principal | `[ 2 0 ; 0 5 ]` |
| **Identidade (I)** | Diagonal com 1 na diagonal principal | `[ 1 0 ; 0 1 ]` |
| **Triangular superior** | Quadrada, zeros abaixo da diagonal | `[ 1 4 ; 0 3 ]` |
| **Triangular inferior** | Quadrada, zeros acima da diagonal | `[ 1 0 ; 6 3 ]` |
| **Simétrica** | Quadrada, aᵢⱼ = aⱼᵢ | `[ 1 7 ; 7 2 ]` |
| **Oposta de A** | −A: troca o sinal de todos os elementos | |

### Dois termos que aparecem demais

**Diagonal principal:** os elementos onde i = j, ou seja, a₁₁, a₂₂, a₃₃... (canto superior esquerdo até o inferior direito).

**Diagonal secundária:** a outra, do canto superior direito ao inferior esquerdo. Os elementos dela em matriz n × n satisfazem i + j = n + 1.

### A matriz identidade merece destaque

A identidade **I** é o "número 1" das matrizes: multiplicar qualquer matriz por ela não muda nada (veremos na multiplicação). As versões 2 × 2 e 3 × 3:

```
I₂ = [ 1  0 ]      I₃ = [ 1  0  0 ]
     [ 0  1 ]           [ 0  1  0 ]
                        [ 0  0  1 ]
```

---

## Parte 3: Operações com matrizes

### 3.1 Adição e subtração

Só dá pra somar (ou subtrair) matrizes **de mesma ordem**. Soma-se elemento com elemento na mesma posição.

```
[ 1  2 ]   [ 5  0 ]   [ 6  2 ]
[ 3  4 ] + [ 1  7 ] = [ 4 11 ]
```

Propriedades que você já conhece dos números e continuam valendo: comutativa (A + B = B + A), associativa, existe elemento neutro (a matriz nula) e toda matriz tem oposta (A + (−A) = 0).

### 3.2 Multiplicação por um número (escalar)

Multiplica-se **todos** os elementos pelo número.

```
    [ 1  -2 ]   [  3  -6 ]
3 · [ 0   4 ] = [  0  12 ]
```

Detalhe importante que vai voltar nos determinantes: aqui o número entra em **todos** os elementos, não em uma linha só.

### 3.3 Multiplicação de matrizes (a operação que todo mundo odeia no começo)

Esqueça a ideia de multiplicar elemento com elemento. Não funciona assim. A regra é:

> O elemento da posição (i, j) do produto é a soma dos produtos dos elementos da **linha i** da primeira matriz com os elementos correspondentes da **coluna j** da segunda.

**Condição de existência:** o número de **colunas da primeira** deve ser igual ao número de **linhas da segunda**.

```
A (m × n)  ·  B (n × p)  =  C (m × p)
        └── iguais ──┘
```

A ordem do resultado é m × p (sobram as "pontas").

#### Exemplo 1 (2 × 2 com 2 × 2)

```
A = [ 1  2 ]     B = [ 0  1 ]
    [ 3  4 ]         [ 1  0 ]
```

Calculando A · B:

- c₁₁ = linha 1 de A · coluna 1 de B = 1·0 + 2·1 = 2
- c₁₂ = linha 1 de A · coluna 2 de B = 1·1 + 2·0 = 1
- c₂₁ = linha 2 de A · coluna 1 de B = 3·0 + 4·1 = 4
- c₂₂ = linha 2 de A · coluna 2 de B = 3·1 + 4·0 = 3

```
A · B = [ 2  1 ]
        [ 4  3 ]
```

Agora B · A:

- c₁₁ = 0·1 + 1·3 = 3
- c₁₂ = 0·2 + 1·4 = 4
- c₂₁ = 1·1 + 0·3 = 1
- c₂₂ = 1·2 + 0·4 = 2

```
B · A = [ 3  4 ]
        [ 1  2 ]
```

**A · B ≠ B · A.** Esse é o fato mais importante da multiplicação de matrizes: **ela não é comutativa** (a ordem importa). Repare no que aconteceu: B é uma matriz que "troca posições". Multiplicar por ela **à direita** (A · B) trocou as **colunas** de A. Multiplicar **à esquerda** (B · A) trocou as **linhas**.

#### Exemplo 2 (3 × 2 com 2 × 3)

```
A = [ 1  2 ]      B = [ 2  0  1 ]
    [ 0  3 ]          [ 1  5  3 ]
    [ 4  1 ]
```

A tem 2 colunas, B tem 2 linhas: existe. Resultado: 3 × 3.

```
A · B = [ 1·2+2·1   1·0+2·5   1·1+2·3 ]   [  4  10   7 ]
        [ 0·2+3·1   0·0+3·5   0·1+3·3 ] = [  3  15   9 ]
        [ 4·2+1·1   4·0+1·5   4·1+1·3 ]   [  9   5   7 ]
```

Já B · A: B é 2 × 3, A é 3 × 2, então existe e dá 2 × 2. **Um produto pode ser 3 × 3 e o outro 2 × 2.** Bem diferente.

#### Exemplo inusitado: contando caminhos numa rede social

Três pessoas: A, B e C. Quem segue quem: A segue B, B segue C, C segue A e B. Montamos a matriz M onde mᵢⱼ = 1 se i segue j (linhas: quem segue; colunas: quem é seguido, na ordem A, B, C).

```
    A  B  C
A [ 0  1  0 ]
B [ 0  0  1 ]
C [ 1  1  0 ]
```

Quando você calcula M², o elemento (i, j) conta **quantos caminhos de 2 passos** vão de i até j ("seguido de seguido"):

```
M² = [ 0  0  1 ]
     [ 1  1  0 ]
     [ 0  1  1 ]
```

Leitura: de A pra C existe 1 caminho de dois passos (A → B → C). De B pra B existe 1 (B → C → B). Sem magia, é só multiplicação de matrizes fazendo a contagem pra você. Esse é o princípio por trás de algoritmos de ranking em redes.

#### Propriedades da multiplicação

Valem (quando as ordens permitem):

- **Associativa:** (A·B)·C = A·(B·C)
- **Distributiva:** A·(B + C) = A·B + A·C
- **Elemento neutro:** A·I = I·A = A (a identidade faz o papel do número 1)
- **Transposta do produto:** (A·B)ᵀ = Bᵀ·Aᵀ (a ordem inverte)

**Não** valem:

- **Comutatividade:** em geral A·B ≠ B·A
- **Cancelamento do zero:** A·B = 0 **não** implica A = 0 ou B = 0. Exemplo:

```
[ 1  0 ]   [ 0  0 ]   [ 0  0 ]
[ 0  0 ] · [ 0  1 ] = [ 0  0 ]
```

Duas matrizes não nulas que multiplicadas dão a nula. Nos números reais isso é impossível, em matrizes acontece.

### 3.4 Matriz transposta

A transposta de A, escrita **Aᵀ**, troca linhas por colunas: a linha 1 vira a coluna 1, a linha 2 vira a coluna 2, e assim por diante.

```
A = [ 1  2  3 ]      Aᵀ = [ 1  4 ]
    [ 4  5  6 ]           [ 2  5 ]
                          [ 3  6 ]
```

Se A é m × n, então Aᵀ é n × m.

Propriedades: (Aᵀ)ᵀ = A, (A + B)ᵀ = Aᵀ + Bᵀ, (k·A)ᵀ = k·Aᵀ, (A·B)ᵀ = Bᵀ·Aᵀ.

Uma matriz quadrada é **simétrica** quando A = Aᵀ (espelhada pela diagonal principal).

---

## Parte 4: Determinantes

### 4.1 Só existe pra matriz quadrada

Determinante é definido **somente para matrizes quadradas**. Notação: det A ou |A| (barras retas no lugar dos colchetes).

Cuidado com um erro clássico: |A| **não** é valor absoluto aqui. O determinante pode ser negativo.

### 4.2 Ordem 1

Se A = [a], então det A = a. Trivial.

### 4.3 Ordem 2: diagonal principal menos diagonal secundária

```
| a  b |
| c  d | = a·d − b·c
```

Multiplica a diagonal principal, multiplica a secundária e subtrai.

**Exemplo:**

```
| 3  5 |
| 2  4 | = 3·4 − 5·2 = 12 − 10 = 2
```

### 4.4 Ordem 3: Regra de Sarrus

Para matrizes 3 × 3 existe um dispositivo prático. Você repete as duas primeiras colunas à direita da matriz, soma os produtos das três diagonais que descem (da esquerda pra direita) e subtrai os produtos das três que sobem.

```
| a  b  c | a  b
| d  e  f | d  e
| g  h  i | g  h
```

```
det = (a·e·i + b·f·g + c·d·h) − (c·e·g + a·f·h + b·d·i)
```

**Exemplo:**

```
    [ 2  1  3 ]
A = [ 0  4  1 ]
    [ 5  2  1 ]
```

Diagonais que descem:
- 2·4·1 = 8
- 1·1·5 = 5
- 3·0·2 = 0

Soma = 13.

Diagonais que sobem:
- 3·4·5 = 60
- 2·1·2 = 4
- 1·0·1 = 0

Soma = 64.

**det A = 13 − 64 = −51.**

⚠️ **Sarrus só funciona para 3 × 3.** Tentar aplicar em 4 × 4 dá resultado errado. Pra ordem maior você precisa de Laplace ou de triangularização.

### 4.5 Menor complementar e cofator

Esses dois conceitos são a base do Teorema de Laplace.

**Menor complementar (Mᵢⱼ):** o determinante da matriz que sobra quando você apaga a linha i e a coluna j do elemento aᵢⱼ.

**Cofator (Cᵢⱼ):** o menor complementar com um sinal:

```
Cᵢⱼ = (−1)^(i+j) · Mᵢⱼ
```

O sinal segue um padrão de tabuleiro de xadrez, começando com + no canto superior esquerdo:

```
+  −  +  −
−  +  −  +
+  −  +  −
−  +  −  +
```

**Exemplo:** na matriz A de Sarrus acima, calcule o cofator de a₁₂ = 1.

Apaga linha 1 e coluna 2:

```
[ 0  1 ]
[ 5  1 ]   → determinante: 0·1 − 1·5 = −5
```

M₁₂ = −5. O sinal de (1,2) é (−1)^(1+2) = −1. Então **C₁₂ = −1 · (−5) = 5**.

### 4.6 Teorema de Laplace

> O determinante de uma matriz quadrada de ordem n ≥ 2 é a soma dos produtos dos elementos de **qualquer** linha (ou coluna) pelos seus respectivos cofatores.

Você escolhe uma fila (linha ou coluna) e expande. A escolha não altera o resultado, então a estratégia esperta é **escolher a fila com mais zeros**, porque zero vezes cofator é zero e você economiza cálculo.

#### Conferindo com o exemplo de Sarrus

Expandindo A pela **linha 1** (elementos 2, 1, 3):

- a₁₁ = 2, cofator = +det[[4,1],[2,1]] = 4·1 − 1·2 = 2 → produto 2·2 = 4
- a₁₂ = 1, cofator = −det[[0,1],[5,1]] = −(0·1 − 1·5) = 5 → produto 1·5 = 5
- a₁₃ = 3, cofator = +det[[0,4],[5,2]] = 0·2 − 4·5 = −20 → produto 3·(−20) = −60

Soma: 4 + 5 − 60 = **−51**. Bate com Sarrus, como deveria.

#### Exemplo 4 × 4 (onde Laplace brilha)

```
    [ 2  0  1  3 ]
A = [ 1  0  4  2 ]
    [ 0  3  0  1 ]
    [ 2  0  5  1 ]
```

Olhe a coluna 2: [0, 0, 3, 0]. Só um elemento não nulo: a₃₂ = 3. Expandindo por essa coluna sobra um único termo:

```
det A = a₃₂ · (−1)^(3+2) · M₃₂ = 3 · (−1) · M₃₂
```

M₃₂ é o determinante da matriz sem a linha 3 e sem a coluna 2:

```
| 2  1  3 |
| 1  4  2 |
| 2  5  1 |
```

Por Sarrus: descem: 2·4·1 + 1·2·2 + 3·1·5 = 8 + 4 + 15 = 27. Sobem: 3·4·2 + 2·2·5 + 1·1·1 = 24 + 20 + 1 = 45. M₃₂ = 27 − 45 = −18.

**det A = 3 · (−1) · (−18) = 54.**

Um determinante 4 × 4 virou um 3 × 3 só porque escolhemos a coluna certa.

### 4.7 Propriedades dos determinantes (o atalho pra tudo)

Essas propriedades são o que separa quem calcula na força bruta de quem resolve em 30 segundos.

**P1. Fila nula → det = 0.**
Se uma linha ou coluna é toda de zeros, o determinante é 0.

**P2. Filas iguais → det = 0.**
Duas linhas (ou colunas) iguais zeram o determinante.

**P3. Filas proporcionais → det = 0.**

```
| 1  2 |
| 3  6 | = 6 − 6 = 0      (linha 2 = 3 × linha 1)
```

Uma fila que é combinação de outras (por exemplo, a soma de duas) também zera o determinante. Exemplo clássico:

```
| 1  2  3 |
| 4  5  6 |
| 7  8  9 | = 0
```

Aqui a linha 3 = 2 × linha 2 − linha 1 (cheque: 2·4 − 1 = 7, 2·5 − 2 = 8, 2·6 − 3 = 9). Por Sarrus: desce 45 + 84 + 96 = 225, sobe 105 + 48 + 72 = 225, diferença 0.

**P4. Trocar duas filas paralelas → o determinante troca de sinal.**

```
| 3  5 |            | 2  4 |
| 2  4 | = 2         | 3  5 | = 10 − 12 = −2
```

**P5. Multiplicar UMA fila por k → o determinante fica multiplicado por k.**

```
| 6  10 |
| 2   4 | = 24 − 20 = 4 = 2 · (det original = 2)
```

(Primeira linha multiplicada por 2.)

**P6. Multiplicar a matriz INTEIRA por k → det fica multiplicado por kⁿ** (n = ordem).
Cada uma das n linhas ganha um fator k. Pra matriz 2 × 2 com det 2, multiplicar tudo por 2 dá det = 2² · 2 = 8. Confira: [[6,10],[4,8]] → 48 − 40 = 8. ✓

Erro clássico: dizer que det(3A) = 3·det A. Em matriz 3 × 3 é 3³ = 27 vezes.

**P7. Teorema de Jacobi: somar a uma fila um múltiplo de outra fila paralela não altera o determinante.**
Essa é a propriedade mais poderosa para cálculo, porque permite **criar zeros** sem mudar o resultado.

```
| 3  5 |   R2 ← R2 + 2·R1    | 3   5 |
| 2  4 | ────────────────▶   | 8  14 | = 3·14 − 5·8 = 42 − 40 = 2   (igual ao original)
```

**P8. Transposta: det Aᵀ = det A.**
Tudo que vale para linhas vale para colunas.

**P9. Teorema de Binet: det(A·B) = det A · det B.**
Conferindo com as matrizes do exemplo de multiplicação: det[[1,2],[3,4]] = −2, det[[0,1],[1,0]] = −1, e A·B = [[2,1],[4,3]] tem det 6 − 4 = 2 = (−2)(−1). ✓

**P10. Matriz triangular (ou diagonal) → det = produto da diagonal principal.**

```
| 2  7  1 |
| 0  3  5 | = 2 · 3 · 4 = 24
| 0  0  4 |
```

**P11. Inversa: det A⁻¹ = 1 / det A.** (quando a inversa existe)

### 4.8 Estratégia de triangularização (Gauss)

Combinando P7 (criar zeros sem alterar o det), P4 (troca de linhas inverte o sinal) e P10 (triangular = produto da diagonal), você calcula o determinante de qualquer matriz de ordem grande sem Laplace repetido.

Regra do jogo:
- Somar múltiplo de uma linha a outra: não muda nada.
- Trocar duas linhas: multiplica o det por −1 (anote).
- Multiplicar uma linha por k: multiplica o det por k (evite ou compense).

**Exemplo:** a mesma matriz 3 × 3 de Sarrus.

```
[ 2  1  3 ]
[ 0  4  1 ]
[ 5  2  1 ]
```

1. R3 ← R3 − (5/2)·R1 = [0, 2 − 5/2, 1 − 15/2] = [0, −1/2, −13/2]
2. R3 ← R3 + (1/8)·R2 = [0, 0, −13/2 + 1/8] = [0, 0, −51/8]

Matriz triangular:

```
[ 2  1    3    ]
[ 0  4    1    ]
[ 0  0  −51/8  ]
```

det = 2 · 4 · (−51/8) = −51. ✓ Mesmo resultado, caminho completamente diferente.

### 4.9 O que o determinante significa (geometria)

Numa matriz 2 × 2 cujas **colunas** são dois vetores, |det| é a **área do paralelogramo** formado por esses vetores. Com os vetores (3, 1) e (1, 2): det = 3·2 − 1·1 = 5, área 5.

E o sinal indica **orientação**: determinante positivo mantém o "sentido horário/anti-horário" original, negativo inverte (como um espelho).

Se det = 0, o paralelogramo é "achatado" numa linha (os vetores são paralelos). Isso conecta tudo: det = 0 significa que a matriz **colapsa** o espaço, perde informação, e por isso não tem volta (não tem inversa).

---

## Parte 5: Matriz inversa

### 5.1 Definição

A inversa de uma matriz quadrada A é a matriz A⁻¹ tal que:

```
A · A⁻¹ = A⁻¹ · A = I
```

Nos números, a inversa de 5 é 1/5, porque 5 · (1/5) = 1. Com matrizes a ideia é a mesma, com I no papel do 1.

**Condição:** A tem inversa **se e somente se det A ≠ 0.** Matriz com inversa é chamada de **invertível** (ou não singular). Com det = 0 ela é **singular**.

Propriedades: (A⁻¹)⁻¹ = A, (A·B)⁻¹ = B⁻¹·A⁻¹ (ordem inverte de novo), (Aᵀ)⁻¹ = (A⁻¹)ᵀ.

### 5.2 Inversa 2 × 2 (fórmula direta)

```
A = [ a  b ]   →   A⁻¹ = 1/(ad − bc) · [  d  −b ]
    [ c  d ]                             [ −c   a ]
```

Troca os elementos da diagonal principal, troca o sinal dos da secundária e divide tudo pelo determinante.

**Exemplo:** A = [[3, 5], [2, 4]], det = 2.

```
A⁻¹ = 1/2 · [  4  −5 ]   [   2   −5/2 ]
            [ −2   3 ] = [  −1    3/2 ]
```

Conferindo (linha 1 de A · colunas de A⁻¹): 3·2 + 5·(−1) = 1 ✓; 3·(−5/2) + 5·(3/2) = 0 ✓. Linha 2: 2·2 + 4·(−1) = 0 ✓; 2·(−5/2) + 4·(3/2) = 1 ✓. Deu a identidade.

### 5.3 Inversa por matriz adjunta (qualquer ordem)

A fórmula geral:

```
A⁻¹ = (1 / det A) · adj(A)
```

Onde **adj(A)** (adjunta) é a **transposta da matriz dos cofatores**.

Passos:
1. Calcule det A (se for 0, pare: não tem inversa).
2. Calcule o cofator de cada elemento e monte a matriz dos cofatores.
3. Transponha essa matriz: essa é a adjunta.
4. Divida tudo por det A.

**Exemplo 3 × 3:**

```
    [ 2  0  1 ]
A = [ 1  1  0 ]
    [ 0  3  1 ]
```

**Passo 1.** Por Sarrus: desce 2·1·1 + 0·0·0 + 1·1·3 = 5; sobe 1·1·0 + 2·0·3 + 0·1·1 = 0. **det A = 5** (≠ 0, tem inversa).

**Passo 2.** Cofatores:

- C₁₁ = +det[[1,0],[3,1]] = 1
- C₁₂ = −det[[1,0],[0,1]] = −1
- C₁₃ = +det[[1,1],[0,3]] = 3
- C₂₁ = −det[[0,1],[3,1]] = −(0 − 3) = 3
- C₂₂ = +det[[2,1],[0,1]] = 2
- C₂₃ = −det[[2,0],[0,3]] = −6
- C₃₁ = +det[[0,1],[1,0]] = −1
- C₃₂ = −det[[2,1],[1,0]] = −(0 − 1) = 1
- C₃₃ = +det[[2,0],[1,1]] = 2

Matriz dos cofatores:

```
C = [  1  −1   3 ]
    [  3   2  −6 ]
    [ −1   1   2 ]
```

**Passo 3.** Adjunta = Cᵀ:

```
adj(A) = [  1   3  −1 ]
         [ −1   2   1 ]
         [  3  −6   2 ]
```

**Passo 4.** A⁻¹ = (1/5) · adj(A).

**Verificação** (sempre faça): A · adj(A) deve dar det A · I = 5·I.

```
[ 2  0  1 ]   [  1   3  −1 ]   [ 5  0  0 ]
[ 1  1  0 ] · [ −1   2   1 ] = [ 0  5  0 ]
[ 0  3  1 ]   [  3  −6   2 ]   [ 0  0  5 ]
```

Deu 5·I, então a adjunta está certa. ✓

### 5.4 Inversa por escalonamento (Gauss-Jordan), só a ideia

Existe um terceiro jeito, que é o mais eficiente em matrizes grandes (é o que computador usa): escreva [A | I] lado a lado e aplique operações nas linhas até transformar A em I. O que aparecer no lado direito é A⁻¹. Você vai ver isso com calma em Álgebra Linear. Para prova de ensino médio/técnico, a adjunta é o caminho esperado.

---

## Parte 6: Aplicações

### 6.1 Sistemas lineares e Regra de Cramer

Um sistema de equações vira uma equação matricial:

```
2x +  y =  7           [ 2   1 ]   [ x ]   [  7 ]
 x −  y = −1    ⟺      [ 1  −1 ] · [ y ] = [ −1 ]
```

Ou seja, A·X = B. Se det A ≠ 0, a solução é única e vale X = A⁻¹·B.

A **Regra de Cramer** dá cada incógnita como razão de determinantes. Seja D = det A. Para achar x, troque a coluna dos coeficientes de x pela coluna dos termos independentes e calcule Dₓ; para y, troque a coluna de y e calcule D_y. Então x = Dₓ/D e y = D_y/D.

Para o sistema acima:

- D = det[[2, 1], [1, −1]] = −2 − 1 = −3
- Dₓ = det[[7, 1], [−1, −1]] = −7 + 1 = −6, logo x = −6/−3 = **2**
- D_y = det[[2, 7], [1, −1]] = −2 − 7 = −9, logo y = −9/−3 = **3**

Conferindo: 2·2 + 3 = 7 ✓; 2 − 3 = −1 ✓.

O que o determinante diz sobre o sistema:
- **D ≠ 0:** solução única (sistema possível e determinado).
- **D = 0:** ou não tem solução, ou tem infinitas. Precisa investigar mais (olhar Dₓ, D_y etc. ou escalonar).

Cramer é elegante, mas é lento para sistemas grandes. Para 2 × 2 e 3 × 3, funciona bem.

### 6.2 Transformações geométricas

Multiplicar uma matriz por um ponto (escrito como coluna) **move o ponto**. É assim que jogos e programas gráficos giram, esticam e espelham objetos.

**Rotação de 90° anti-horária:**

```
R = [ 0  −1 ]
    [ 1   0 ]
```

Aplicada ao ponto (2, 3): R · [2; 3] = [0·2 − 1·3 ; 1·2 + 0·3] = [−3 ; 2]. O ponto (2, 3) foi parar em (−3, 2).

**Reflexão no eixo x:**

```
S = [ 1   0 ]
    [ 0  −1 ]
```

**Escala (esticar 2× na horizontal e 3× na vertical):**

```
E = [ 2  0 ]
    [ 0  3 ]
```

O determinante conta a história de cada uma:
- det R = 0·0 − (−1)(1) = **1**: rotação preserva área e orientação.
- det S = **−1**: reflexão preserva área mas inverte orientação (espelho).
- det E = **6**: a área de qualquer figura fica multiplicada por 6.

### 6.3 Criptografia de Hill (aplicação inusitada)

Em 1929 o matemático Lester Hill criou uma cifra que usa matrizes. A chave é uma matriz quadrada K, e as letras viram números (A=0, B=1, ..., Z=25). Você codifica blocos de letras multiplicando por K e tirando o resto da divisão por 26.

Escolha K = [[3, 3], [2, 5]]. Seu determinante é 15 − 6 = 9, e 9 não tem fator em comum com 26, então K serve (o determinante precisa ter inversa módulo 26, senão você não consegue decifrar).

**Cifrar "HI":** H = 7, I = 8.

```
K · [7] = [3·7 + 3·8] = [45] ≡ [19]   (mod 26)
    [8]   [2·7 + 5·8]   [54]   [ 2]
```

19 = T, 2 = C. "HI" virou **"TC"**.

**Decifrar:** precisa da inversa de K módulo 26. Como 9 · 3 = 27 ≡ 1 (mod 26), o "inverso" do determinante é 3. Então K⁻¹ = 3 · adj(K) = 3 · [[5, −3], [−2, 3]] = [[15, −9], [−6, 9]] ≡ [[15, 17], [20, 9]] (mod 26).

```
K⁻¹ · [19] = [15·19 + 17·2] = [319] ≡ [7]  (H)
      [ 2]   [20·19 +  9·2]   [398]   [8]  (I)
```

Voltou "HI". É a mesma ideia de inversa da Parte 5, só que com aritmética de relógio. (Como cifra real ela é fraca hoje em dia, mas é ótima pra enxergar matrizes funcionando em algo inesperado.)

### 6.4 Outras aplicações em uma frase

- **Computação gráfica:** toda rotação, escala e projeção 3D é multiplicação de matriz.
- **Machine learning:** redes neurais são, no fundo, pilhas de multiplicações de matrizes.
- **Economia:** modelo de insumo-produto de Leontief usa matrizes e inversas para calcular o impacto de um setor nos outros.
- **Redes e grafos:** a matriz de adjacência (vista na Parte 3) conta caminhos.

---

## Parte 7: Erros comuns

1. **Multiplicar matrizes elemento a elemento.** O produto é linha × coluna com soma.
2. **Assumir A·B = B·A.** Quase nunca vale.
3. **Esquecer a condição de existência** (colunas da 1ª = linhas da 2ª).
4. **Aplicar Sarrus em matriz 4 × 4.** Só serve pra 3 × 3.
5. **det(k·A) = k·det A.** Errado. É kⁿ · det A.
6. **det(A + B) = det A + det B.** Errado. Determinante **não** é aditivo. Só é multiplicativo (Binet).
7. **Errar o sinal do cofator.** Sempre (−1)^(i+j).
8. **Esquecer a transposição na adjunta.** Adjunta é a transposta da matriz dos cofatores.
9. **Tentar inverter matriz com det = 0.** Não existe.
10. **Confundir |A| com módulo.** Determinante pode ser negativo.

---

## Parte 8: Para praticar

Tente antes de olhar o gabarito. Se travar, volte na parte correspondente.

**1.** Construa A de ordem 2 × 3 com aᵢⱼ = 2i − j.

**2.** Calcule [[1, 2], [3, 4]] · [[5], [6]].

**3.** Calcule o determinante de [[1, 2, 3], [4, 5, 6], [7, 8, 9]] **sem fazer conta longa**, usando propriedades.

**4.** Para que valores de x a matriz [[x, 2], [3, x + 1]] **não** tem inversa?

**5.** A é 3 × 3 e det A = 4. Quanto vale det(3A)?

**6.** A é 4 × 4 e det A = −2. Calcule det(Aᵀ), det(A⁻¹) e det(2A).

**7.** Resolva por Cramer: x + 2y = 4 e 3x − y = 5.

**8.** Calcule o determinante por Laplace, escolhendo a melhor fila:

```
[ 3  0  2 ]
[ 1  0  5 ]
[ 4  7  1 ]
```

### Gabarito

**1.** a₁₁ = 1, a₁₂ = 0, a₁₃ = −1, a₂₁ = 3, a₂₂ = 2, a₂₃ = 1:
```
[ 1  0  −1 ]
[ 3  2   1 ]
```

**2.** Matriz 2 × 1: [1·5 + 2·6 ; 3·5 + 4·6] = **[17 ; 39]**.

**3.** **0.** A linha 3 é 2·(linha 2) − (linha 1), então uma fila é combinação das outras.

**4.** Sem inversa quando det = 0: x(x + 1) − 6 = 0 → x² + x − 6 = 0 → **x = 2 ou x = −3.**

**5.** 3³ · 4 = 27 · 4 = **108.**

**6.** det(Aᵀ) = **−2**; det(A⁻¹) = 1/(−2) = **−1/2**; det(2A) = 2⁴ · (−2) = 16 · (−2) = **−32.**

**7.** D = det[[1, 2], [3, −1]] = −1 − 6 = −7. Dₓ = det[[4, 2], [5, −1]] = −4 − 10 = −14, então x = 2. D_y = det[[1, 4], [3, 5]] = 5 − 12 = −7, então y = 1. **(x, y) = (2, 1).** Confere: 2 + 2 = 4 ✓; 6 − 1 = 5 ✓.

**8.** A coluna 2 é [0, 0, 7], então só o elemento a₃₂ = 7 sobrevive. Sinal de (3,2): (−1)^5 = −1. Menor M₃₂ = det[[3, 2], [1, 5]] = 15 − 2 = 13. det = 7 · (−1) · 13 = **−91.**

---

## Síntese

- **Matriz** é uma tabela m × n; o elemento aᵢⱼ fica na linha i, coluna j.
- **Soma** exige mesma ordem; **produto** exige colunas da 1ª = linhas da 2ª, e **não é comutativo**.
- **Determinante** só existe para quadradas: 2 × 2 é diagonal principal menos secundária, 3 × 3 é Sarrus, maiores usam Laplace (escolhendo a fila com zeros) ou triangularização.
- As propriedades mais úteis: fila nula/repetida/proporcional dá 0; trocar filas inverte o sinal; Jacobi permite criar zeros; det(AB) = det A · det B; det(kA) = kⁿ · det A.
- **Inversa** existe só se det ≠ 0. Fórmula: A⁻¹ = adj(A) / det A.
- det = 0 é o sinal de alerta universal: sem inversa, sistema sem solução única, figura "achatada".

### Para onde ir depois

- **Álgebra Linear:** espaços vetoriais, autovalores e autovetores, diagonalização. É a continuação natural.
- **Escalonamento e Gauss-Jordan**, que é como se resolve sistema grande de verdade.
- **Computação:** brincar com NumPy (`numpy.linalg.det`, `numpy.linalg.inv`, operador `@` para multiplicar) deixa os conceitos muito mais concretos.
- Conteúdos de canais de vídeo de Álgebra Linear com foco geométrico ajudam bastante a "ver" o que o determinante faz.

---

## Referências

Conteúdo conferido em mais de uma fonte; os exemplos numéricos foram todos recalculados e verificados por caminhos diferentes (por exemplo, Sarrus contra Laplace contra triangularização).

- Preparaenem (Brasil Escola): páginas sobre Teorema de Laplace, Regra de Sarrus, Propriedades dos determinantes e Matrizes e determinantes. https://www.preparaenem.com/matematica/matrizes-determinantes.htm
- UFRN, Instituto Metrópole Digital: Matemática Aplicada, Matrizes parte 2 (cofator e Laplace). https://hmateriais.imd.ufrn.br/materialV2/assets/download/matematica-aplicada/05-matrizes-parte-2-MATEMATICA-APLICADA-IMD.pdf
- Dissertação UFC (2014), Determinantes no ensino médio: Sarrus, Laplace e propriedades. https://repositorio.ufc.br/ri/bitstream/riufc/8956/1/2014_dis_cdmsilva.pdf
- Revista Sigmae (UNIFAL-MG): determinante como função multilinear e alternada. https://publicacoes.unifal-mg.edu.br/revistas/index.php/sigmae/article/download/91/26
- Estratégia Militares: Matrizes e determinantes, conceitos essenciais. https://militares.estrategia.com/portal/materias-e-dicas/matematica/matrizes-e-determinantes-conceitos-essenciais/
- Cifra de Hill (seção 6.3) e aplicações da seção 6.4 são conhecimento padrão de Álgebra Linear, não vieram de uma das fontes acima.
