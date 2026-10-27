# Sistemas Lineares e Equações Lineares

## Introdução

### O que é isso, afinal?

Uma **equação linear** é uma equação "sem graça" no melhor sentido: as incógnitas aparecem só somadas entre si, cada uma multiplicada por um número. Nada de potência, raiz, produto entre incógnitas ou seno. Um **sistema linear** é um conjunto de equações lineares que precisam ser verdadeiras **ao mesmo tempo**.

Parece básico, mas sistemas lineares são provavelmente a ferramenta mais usada da matemática aplicada. Computação gráfica, previsão do tempo, engenharia de circuitos, economia, balanceamento de reações químicas, inteligência artificial: tudo isso acaba, em algum ponto, resolvendo sistemas lineares gigantes.

### Pré-requisitos

Resolver uma equação do 1º grau como `3x + 5 = 20`. Se você sabe isolar o x, já dá pra começar. Matrizes e determinantes ajudam a partir da Parte 5, mas explico o necessário quando aparecem (se quiser a base completa, a apostila de Matrizes e Determinantes cobre isso).

### O que esta apostila cobre

1. Equação linear e seu significado geométrico
2. Sistema linear: solução e classificação (SPD, SPI, SI)
3. Métodos elementares (substituição e adição)
4. Escalonamento (método de Gauss), o mais importante da apostila
5. Regra de Cramer e discussão de sistemas com parâmetro
6. Teorema de Rouché-Capelli (a visão "profissional" da classificação)
7. Modelagem de problemas, do convencional ao inusitado
8. Erros comuns, exercícios e gabarito

### Convenções

Vírgula decimal, como no padrão brasileiro. Frações aparecem como `a/b` quando o resultado não é inteiro. Matrizes e sistemas vão em blocos de código para manter o alinhamento.

---

## Parte 1: Equação linear

### 1.1 Definição

Uma equação linear nas incógnitas x₁, x₂, ..., xₙ tem a forma:

```
a₁·x₁ + a₂·x₂ + ... + aₙ·xₙ = b
```

- **a₁, a₂, ..., aₙ** são os **coeficientes** (números reais).
- **b** é o **termo independente**.
- Cada incógnita aparece com **expoente 1** e **não** é multiplicada por outra incógnita.

**São lineares:**
- `2x + 3y = 7`
- `x − y + 4z = 0`
- `x/2 + y = 10` (coeficiente 1/2 é um número como outro qualquer)
- `5x = 15`

**NÃO são lineares:**
- `x² + y = 4` (expoente 2)
- `x·y = 6` (produto de incógnitas)
- `√x + y = 3` (raiz da incógnita)
- `sen(x) + y = 1` (função da incógnita)
- `1/x + y = 2` (incógnita no denominador)

Truque pra reconhecer: se o gráfico for uma **reta** (duas incógnitas) ou um **plano** (três), é linear. Daí o nome.

Quando b = 0, a equação é dita **homogênea**.

### 1.2 O que é "solução" de uma equação linear

Solução é uma lista de valores (um para cada incógnita) que, colocados na equação, deixam a igualdade verdadeira. Escrevemos como par, trio, ou n-upla ordenada.

Para `2x + 3y = 12`, o par (3, 2) é solução (6 + 6 = 12 ✓). Mas (0, 4) também (0 + 12 = 12 ✓), e (6, 0), e (1,5; 3)...

Uma equação com duas incógnitas tem **infinitas soluções**. Cada valor de x escolhido determina um y. Para listar todas de uma vez, usamos um **parâmetro**:

```
2x + 3y = 12  →  isolando x:  x = (12 − 3y)/2 = 6 − (3/2)·y

Chamando y = t (qualquer número real):  solução geral = ( 6 − 3t/2 , t )
```

Com t = 2 sai (3, 2). Com t = 0 sai (6, 0). Uma fórmula, infinitas soluções.

### 1.3 Três casos especiais (importantes para o resto da apostila)

Olhe a equação `a·x = b` com uma incógnita:

| Caso | Exemplo | O que acontece |
|---|---|---|
| a ≠ 0 | `3x = 12` | Uma única solução: x = b/a = 4 |
| a = 0 e b ≠ 0 | `0x = 5` | **Nenhuma** solução (0 nunca vira 5) |
| a = 0 e b = 0 | `0x = 0` | **Infinitas** soluções (qualquer x serve) |

Esses três casos reaparecem a todo momento quando a gente resolve sistemas. O segundo (`0 = 5`) é o "alarme" de que o sistema é impossível. O terceiro (`0 = 0`) indica equação redundante.

### 1.4 Geometria da equação linear

- **2 incógnitas:** `ax + by = c` é uma **reta** no plano. Cada ponto da reta é uma solução.
- **3 incógnitas:** `ax + by + cz = d` é um **plano** no espaço.
- **4 ou mais incógnitas:** vira um "hiperplano" que não dá pra desenhar, mas a lógica é a mesma.

Isso é a chave para entender sistemas: resolver um sistema é achar onde essas retas (ou planos) **se encontram**.

---

## Parte 2: Sistema linear

### 2.1 Definição

Um sistema linear de **m equações** e **n incógnitas** é:

```
a₁₁x₁ + a₁₂x₂ + ... + a₁ₙxₙ = b₁
a₂₁x₁ + a₂₂x₂ + ... + a₂ₙxₙ = b₂
 ...
aₘ₁x₁ + aₘ₂x₂ + ... + aₘₙxₙ = bₘ
```

**Solução do sistema:** uma n-upla que satisfaz **todas** as equações simultaneamente. Atenção ao "todas": uma solução de uma equação só não vale.

**Exemplo:**

```
x + y = 10
x − y = 2
```

O par (6, 4) satisfaz as duas: 6 + 4 = 10 ✓ e 6 − 4 = 2 ✓. O par (5, 5) satisfaz a primeira mas não a segunda (5 − 5 = 0 ≠ 2), então não é solução do sistema.

### 2.2 Classificação: SPD, SPI e SI

Todo sistema linear cai em exatamente uma destas três categorias:

| Sigla | Nome | Soluções |
|---|---|---|
| **SPD** | Sistema Possível e Determinado | Exatamente **uma** |
| **SPI** | Sistema Possível e Indeterminado | **Infinitas** |
| **SI** | Sistema Impossível | **Nenhuma** |

"Possível" = tem solução. "Determinado" = a solução é única, está determinada. Nunca existe sistema linear com exatamente 2 ou 3 soluções: ou é 0, ou 1, ou infinitas.

### 2.3 Visualizando com retas (sistema 2 × 2)

Cada equação é uma reta. Resolver o sistema é achar o ponto comum.

**SPD, retas concorrentes** (se cruzam em um ponto):

```
x + y = 10
x − y = 2        →  única solução (6, 4)
```

**SPI, retas coincidentes** (são a mesma reta):

```
x + 2y = 4
2x + 4y = 8      →  a 2ª equação é a 1ª multiplicada por 2
```

Todas as soluções: x = 4 − 2y. Ou seja, (4 − 2t, t). Exemplos: (4, 0), (2, 1), (0, 2).

**SI, retas paralelas** (nunca se encontram):

```
x + 2y = 4
2x + 4y = 10     →  o lado esquerdo é o dobro, mas 10 ≠ 2·4 = 8
```

Se as duas equações dizem que "x + 2y" vale ao mesmo tempo 4 e 5, é contradição.

### 2.4 Visualizando com planos (sistema 3 × 3)

Cada equação é um plano. As posições possíveis de três planos:

- **Se encontram num único ponto** (como as três paredes de um canto de sala e o chão): SPD.
- **Se encontram numa reta** (como três páginas de um livro aberto, ou três planos passando pelo mesmo eixo): SPI com 1 variável livre.
- **São o mesmo plano** (ou dois coincidem e o terceiro também contém ele): SPI com 2 variáveis livres.
- **Não têm ponto comum:** SI. Casos típicos: dois planos paralelos, ou três planos que se cortam dois a dois formando um "prisma triangular" (dá pra ver na lateral de uma barra de Toblerone), sem nenhum ponto comum aos três.

### 2.5 Sistema homogêneo

Se **todos** os termos independentes são zero, o sistema é **homogêneo**:

```
x + 2y = 0
2x − y = 0
```

Característica fundamental: **sempre tem solução**, pelo menos a **trivial** (tudo zero). Então um sistema homogêneo é SPD (só a trivial) ou SPI (a trivial mais infinitas outras). Nunca é SI.

Exemplo de homogêneo SPI:

```
x + 2y = 0
2x + 4y = 0      →  mesma reta, soluções (−2t, t)
```

### 2.6 Sistemas equivalentes

Dois sistemas são **equivalentes** quando têm **exatamente o mesmo conjunto de soluções**. Todo método de resolução consiste em transformar o sistema original em um equivalente mais fácil, sem perder nem ganhar solução.

Existem três transformações que **sempre** preservam a equivalência:

1. **Trocar** a ordem de duas equações.
2. **Multiplicar** uma equação inteira por um número **diferente de zero**.
3. **Somar** a uma equação um **múltiplo de outra** equação.

Por que funciona? A (1) é óbvia: a ordem não importa. A (2) vale porque se `x + y = 3` é verdade, então `5x + 5y = 15` também é, e dá pra voltar dividindo por 5 (por isso o zero é proibido: multiplicar por 0 apaga a equação e não tem volta). A (3) funciona porque somar duas igualdades verdadeiras gera outra igualdade verdadeira, e dá pra desfazer subtraindo.

Essas três operações são a base do escalonamento.

---

## Parte 3: Métodos elementares (sistemas pequenos)

Pra sistema 2 × 2, os métodos clássicos resolvem rápido.

### 3.1 Método da substituição

Isola uma incógnita em uma equação e substitui na outra.

```
2x + 3y = 12
x − y = 1
```

1. Da 2ª: x = y + 1.
2. Substitui na 1ª: 2(y + 1) + 3y = 12 → 2y + 2 + 3y = 12 → 5y = 10 → **y = 2**.
3. Volta: x = 2 + 1 = **3**.

Conferindo: 2·3 + 3·2 = 12 ✓; 3 − 2 = 1 ✓. Solução (3, 2).

### 3.2 Método da adição

Soma as equações de modo que uma incógnita desapareça. Se necessário, multiplique antes para "alinhar" os coeficientes.

```
x + y = 10
x − y = 2
```

Somando membro a membro: 2x = 12 → x = 6. Substituindo: 6 + y = 10 → y = 4.

Quando os coeficientes não se cancelam sozinhos:

```
2x + 3y = 12     (multiplica por 1)
 x −  y = 1      (multiplica por 3)
```

Fica `2x + 3y = 12` e `3x − 3y = 3`. Somando: 5x = 15 → x = 3, e daí y = 2. Mesma resposta.

Esses métodos funcionam bem até 3 incógnitas. Depois disso, vira bagunça. Daí a necessidade do método sistemático da próxima parte.

---

## Parte 4: Escalonamento (método de Gauss)

Esta é a parte mais importante. O escalonamento resolve **qualquer** sistema linear (qualquer número de equações e incógnitas) e **classifica** ele no processo (SPD, SPI ou SI). É também o que computadores usam.

### 4.1 A ideia

Usar as três operações de equivalência (Parte 2.6) para transformar o sistema em um formato de "escada", onde cada equação tem menos incógnitas que a anterior. Daí a resolução é de baixo pra cima, trivial.

### 4.2 Forma escalonada

Um sistema está **escalonado** quando o primeiro coeficiente não nulo de cada equação fica à **direita** do primeiro coeficiente não nulo da equação de cima.

```
x + y + z = 6
    −3y − z = −9
          −7z = −21
```

Visualmente, uma escada. A última equação tem uma incógnita só (z), a de cima tem duas, e a primeira tem três.

### 4.3 Matriz aumentada: escrever sem repetir as letras

Para não ficar escrevendo x, y, z toda hora, usamos uma matriz que guarda só os números. Os coeficientes ficam à esquerda da barra e os termos independentes à direita.

```
x + y + z = 6                    [ 1   1   1 |  6 ]
2x − y + z = 3         →         [ 2  −1   1 |  3 ]
x + 2y − z = 2                   [ 1   2  −1 |  2 ]
```

As três operações viram operações sobre linhas (L₁, L₂, L₃):

1. Trocar duas linhas: `Lᵢ ↔ Lⱼ`
2. Multiplicar uma linha por k ≠ 0: `Lᵢ ← k·Lᵢ`
3. Somar a uma linha um múltiplo de outra: `Lᵢ ← Lᵢ + k·Lⱼ`

### 4.4 Passo a passo (SPD)

Sistema:

```
x + y + z = 6
2x − y + z = 3
x + 2y − z = 2
```

**Objetivo:** zerar tudo abaixo do primeiro coeficiente da 1ª linha (o "pivô" é o 1 da posição (1,1)), depois zerar abaixo do pivô da 2ª linha.

Matriz aumentada inicial:

```
[ 1   1   1 |  6 ]
[ 2  −1   1 |  3 ]
[ 1   2  −1 |  2 ]
```

**Passo 1.** Zerar a coluna 1 abaixo do pivô:
- `L₂ ← L₂ − 2·L₁`: [2−2, −1−2, 1−2 | 3−12] = [0, −3, −1 | −9]
- `L₃ ← L₃ − L₁`: [1−1, 2−1, −1−1 | 2−6] = [0, 1, −2 | −4]

```
[ 1   1   1 |  6 ]
[ 0  −3  −1 | −9 ]
[ 0   1  −2 | −4 ]
```

**Passo 2.** Zerar a coluna 2 abaixo do pivô −3 (na linha 2):
- `L₃ ← 3·L₃ + L₂`: [0, 3−3, −6−1 | −12−9] = [0, 0, −7 | −21]

(Multiplicamos L₃ por 3 antes de somar para evitar frações. É permitido porque 3 ≠ 0.)

```
[ 1   1   1 |   6 ]
[ 0  −3  −1 |  −9 ]
[ 0   0  −7 | −21 ]
```

Escalonado. Voltando a escrever como sistema:

```
x + y + z = 6
   −3y − z = −9
        −7z = −21
```

**Passo 3: retrossubstituição** (de baixo pra cima):
- −7z = −21 → **z = 3**
- −3y − 3 = −9 → −3y = −6 → **y = 2**
- x + 2 + 3 = 6 → **x = 1**

**Solução: (1, 2, 3). SPD.** Verificação nas equações originais: 1+2+3 = 6 ✓; 2−2+3 = 3 ✓; 1+4−3 = 2 ✓.

### 4.5 Gauss-Jordan (indo até o fim)

Em vez de retrossubstituir, dá pra continuar operando até a parte esquerda virar a identidade. A resposta aparece direto na coluna da direita.

Continuando da matriz escalonada acima:

```
[ 1   1   1 |   6 ]
[ 0  −3  −1 |  −9 ]
[ 0   0  −7 | −21 ]
```

- `L₃ ← L₃ / (−7)`: [0, 0, 1 | 3]
- `L₂ ← L₂ + L₃`: [0, −3, 0 | −6], depois `L₂ ← L₂ / (−3)`: [0, 1, 0 | 2]
- `L₁ ← L₁ − L₂ − L₃`: [1, 0, 0 | 6 − 2 − 3] = [1, 0, 0 | 1]

```
[ 1  0  0 | 1 ]
[ 0  1  0 | 2 ]
[ 0  0  1 | 3 ]
```

Lê-se direto: x = 1, y = 2, z = 3. Mais trabalho de escrita, zero retrossubstituição.

### 4.6 Como o escalonamento classifica o sistema

Depois de escalonar, olhe as linhas do final:

**Caso A: sobra uma equação com uma incógnita e coeficiente ≠ 0** (como `−7z = −21`): isso vai permitir resolver todas as incógnitas, uma por uma. **SPD.**

**Caso B: uma linha zera por completo (`0 = 0`) e sobram menos equações úteis que incógnitas:** sobram **variáveis livres**. **SPI.**

**Caso C: aparece uma linha do tipo `0 = k` com k ≠ 0** (ex.: `0 = 1`): contradição. **SI.**

### 4.7 Exemplo SPI

```
x + y + z = 6
x − y + z = 2
2x      + 2z = 8
```

Matriz aumentada:

```
[ 1   1   1 | 6 ]
[ 1  −1   1 | 2 ]
[ 2   0   2 | 8 ]
```

- `L₂ ← L₂ − L₁`: [0, −2, 0 | −4]
- `L₃ ← L₃ − 2·L₁`: [0, −2, 0 | −4]
- `L₃ ← L₃ − L₂`: [0, 0, 0 | 0]

```
[ 1   1   1 |  6 ]
[ 0  −2   0 | −4 ]
[ 0   0   0 |  0 ]
```

A última linha virou `0 = 0` (equação redundante: a 3ª era a soma das duas primeiras). Sobram **2 equações úteis para 3 incógnitas**, então tem **1 variável livre** (grau de indeterminação 1 = 3 − 2).

Resolvendo:
- −2y = −4 → **y = 2**
- x + 2 + z = 6 → x = 4 − z

Chamando z = t: **solução geral = (4 − t, 2, t)**, com t qualquer número real.

Teste com t = 1: (3, 2, 1). Eq. 1: 3+2+1 = 6 ✓. Eq. 2: 3−2+1 = 2 ✓. Eq. 3: 6+0+2 = 8 ✓.

### 4.8 Exemplo SI

Mesmo sistema, mudando só o termo independente da 3ª equação:

```
x + y + z = 6
x − y + z = 2
2x      + 2z = 9
```

Escalonando do mesmo jeito:
- `L₂ ← L₂ − L₁`: [0, −2, 0 | −4]
- `L₃ ← L₃ − 2·L₁`: [0, −2, 0 | 9 − 12] = [0, −2, 0 | −3]
- `L₃ ← L₃ − L₂`: [0, 0, 0 | −3 + 4] = [0, 0, 0 | 1]

Última linha: **0 = 1**. Contradição. **SI.**

Repare como a diferença entre SPI e SI veio de um único número (8 contra 9): o que decide é se a "combinação" das equações é consistente também nos termos independentes.

### 4.9 Dicas práticas de escalonamento

- Se o pivô for zero, troque de linha com uma de baixo que tenha coeficiente não nulo naquela coluna.
- Prefira pivô 1 (ou −1) para evitar frações. Se a 1ª linha não tem coeficiente 1 em x, troque linhas ou divida.
- **Confira sempre** substituindo a solução nas equações **originais** (não nas transformadas).
- Escreva a operação ao lado de cada passo (`L₂ ← L₂ − 2L₁`). Quando erra, fica fácil achar onde.

---

## Parte 5: Cramer e discussão com parâmetro

### 5.1 Representação matricial

Todo sistema linear pode ser escrito como **A · X = B**:

```
2x + y = 7           [ 2   1 ]   [ x ]   [  7 ]
 x − y = −1    ⟺     [ 1  −1 ] · [ y ] = [ −1 ]
                        A         X         B
```

A é a matriz dos coeficientes, X a coluna das incógnitas e B a coluna dos termos independentes. Quando A é quadrada (mesmo número de equações e incógnitas) e det A ≠ 0, existe A⁻¹ e a solução sai direto: **X = A⁻¹ · B**.

**Exemplo com A de 3 × 3** (a matriz da apostila de Matrizes, cuja inversa já calculamos): resolver

```
2x      + z = 1
 x + y      = 2
     3y + z = 3
```

Aqui A = [[2,0,1],[1,1,0],[0,3,1]], det A = 5 e adj(A) = [[1,3,−1],[−1,2,1],[3,−6,2]]. Então X = (1/5)·adj(A)·B:

```
adj(A) · [1]   [ 1·1 + 3·2 − 1·3 ]   [  4 ]
         [2] = [−1·1 + 2·2 + 1·3 ] = [  6 ]     →  X = (1/5)·[4, 6, −3] = (4/5, 6/5, −3/5)
         [3]   [ 3·1 − 6·2 + 2·3 ]   [ −3 ]
```

Conferindo: 2·(4/5) + (−3/5) = 5/5 = 1 ✓; 4/5 + 6/5 = 2 ✓; 3·(6/5) + (−3/5) = 15/5 = 3 ✓.

### 5.2 Regra de Cramer

Para sistema **quadrado** com D = det A ≠ 0:

- Dₓ = determinante de A com a **coluna de x** trocada pela coluna B.
- D_y = idem para a coluna de y. D_z = idem para z.
- Solução: **x = Dₓ/D, y = D_y/D, z = D_z/D.**

**Exemplo 2 × 2:** `2x + y = 7` e `x − y = −1`.
- D = 2·(−1) − 1·1 = −3
- Dₓ = det[[7, 1], [−1, −1]] = −7 + 1 = −6 → x = −6/−3 = **2**
- D_y = det[[2, 7], [1, −1]] = −2 − 7 = −9 → y = −9/−3 = **3**

**Exemplo 3 × 3:** o mesmo sistema da seção 4.4 (x + y + z = 6, 2x − y + z = 3, x + 2y − z = 2).

- D = det[[1,1,1],[2,−1,1],[1,2,−1]] = 7 (por Sarrus)
- Dₓ = det[[6,1,1],[3,−1,1],[2,2,−1]] = 7 → x = 1
- D_y = det[[1,6,1],[2,3,1],[1,2,−1]] = 14 → y = 2
- D_z = det[[1,1,6],[2,−1,3],[1,2,2]] = 21 → z = 3

Mesma resposta do escalonamento: (1, 2, 3).

**Quando usar Cramer, quando usar escalonamento?**
Cramer só serve quando o sistema é quadrado e D ≠ 0, e fica caro em sistemas grandes (muitos determinantes). Escalonamento serve para qualquer sistema e é mais eficiente. Cramer é ótimo para 2 × 2 e 3 × 3, e especialmente para **discussão com parâmetros**, como veremos.

### 5.3 O que o determinante diz sobre o sistema quadrado

- **D ≠ 0 → SPD** (solução única).
- **D = 0 → SPI ou SI.** O determinante sozinho não diz qual dos dois. É preciso investigar caso a caso (escalonando, ou olhando Dₓ, D_y...).

⚠️ Alguns materiais por aí resumem como "D = 0 é SPI". Isso está incompleto: D = 0 pode ser SI também.

### 5.4 Discussão de sistemas com parâmetro

"Discutir" um sistema é descobrir para que valores de um parâmetro (como k) ele é SPD, SPI ou SI. Método: calcule D em função de k, ache os k que zeram D, e para cada um desses valores resolva o caso à parte.

**Exemplo 1 (2 × 2).**

```
x + 2y = 3
2x + ky = 6
```

D = 1·k − 2·2 = k − 4.

- **k ≠ 4:** D ≠ 0 → **SPD**.
- **k = 4:** o sistema vira `x + 2y = 3` e `2x + 4y = 6`. A 2ª é o dobro da 1ª, consistente nos dois lados → **SPI**.

**Exemplo 2 (2 × 2), com final diferente.**

```
x + y = 2
2x + ky = 5
```

D = k − 2.

- **k ≠ 2:** **SPD**.
- **k = 2:** `2x + 2y = 5`, mas da 1ª temos 2x + 2y = 4. Contradição → **SI**.

Mesmo determinante nulo, desfechos diferentes. É exatamente a ressalva do tópico 5.3.

**Exemplo 3 (3 × 3).**

```
x + y + z = 3
x − y + z = 1
x + y + kz = 4
```

Escalonando só os coeficientes: `L₂ − L₁` dá [0, −2, 0]; `L₃ − L₁` dá [0, 0, k−1]. O determinante é 1 · (−2) · (k − 1) = **−2(k − 1)**, que zera só em k = 1.

- **k ≠ 1:** **SPD**.
- **k = 1:** a 3ª equação vira x + y + z = 4, mas a 1ª diz que x + y + z = 3. **SI.**

(Se o lado direito da 3ª fosse 3 em vez de 4, o caso k = 1 seria SPI.)

### 5.5 Sistema homogêneo e determinante

Para um sistema homogêneo quadrado:
- **D ≠ 0:** só a solução trivial (SPD).
- **D = 0:** infinitas soluções (SPI).

Exemplo: para que valor de m o sistema `x + 2y = 0`, `3x + my = 0` admite soluções não nulas? Precisamos D = 0: D = m − 6 → **m = 6**. (Com m = 6 a 2ª equação é 3 vezes a 1ª.)

---

## Parte 6: Teorema de Rouché-Capelli

Cramer só cuida de sistemas quadrados. E se tiver 3 equações e 4 incógnitas? Ou 4 equações e 2 incógnitas? Aí entra o **Teorema de Rouché-Capelli**, que classifica **qualquer** sistema.

### 6.1 O conceito de posto (ou característica)

O **posto** de uma matriz é o número de **linhas não nulas** que sobram depois de escalonar. É uma medida de quantas linhas são realmente "independentes", sem serem combinação das outras.

Para um sistema A·X = B, olhamos dois postos:
- **p(A):** posto da matriz dos coeficientes.
- **p(A|B):** posto da matriz aumentada.

Seja **n** o número de incógnitas.

### 6.2 O teorema

| Situação | Classificação |
|---|---|
| p(A) < p(A\|B) | **SI** |
| p(A) = p(A\|B) = n | **SPD** |
| p(A) = p(A\|B) < n | **SPI**, com **n − p** variáveis livres |

Em português claro: se acrescentar a coluna B **cria** uma linha "nova" que não existia nos coeficientes (o famoso `0 = k`), é impossível. Se não cria, é possível, e o que decide entre uma ou infinitas soluções é se o posto cobre todas as incógnitas.

### 6.3 Conferindo com os exemplos da Parte 4

**Exemplo SPD (4.4):** escalonada tem 3 linhas não nulas na parte dos coeficientes e 3 na aumentada. p(A) = p(A|B) = 3 = n → SPD ✓.

**Exemplo SPI (4.7):**
```
[ 1   1   1 |  6 ]
[ 0  −2   0 | −4 ]
[ 0   0   0 |  0 ]
```
p(A) = 2, p(A|B) = 2, n = 3 → p = p(A|B) < n → SPI com 3 − 2 = **1** variável livre ✓.

**Exemplo SI (4.8):**
```
[ 1   1   1 |  6 ]
[ 0  −2   0 | −4 ]
[ 0   0   0 |  1 ]
```
p(A) = 2 (a última linha é zero **à esquerda da barra**), mas p(A|B) = 3 (a última linha **não é** zero na aumentada por causa do 1). p(A) < p(A|B) → SI ✓.

### 6.4 Sistemas com mais equações que incógnitas, ou menos

**Mais equações que incógnitas** (sistema "sobredeterminado"): em geral SI, a menos que as equações extras sejam redundantes. Exemplo: três retas no plano raramente passam pelo mesmo ponto.

```
x + y = 3
x − y = 1
2x + y = 5
```

As duas primeiras dão (2, 1). A terceira: 2·2 + 1 = 5 ✓. Aqui as três retas concorrem em um ponto, é SPD (a 3ª equação era redundante). Mudando o 5 para 6, vira SI.

**Menos equações que incógnitas:** nunca é SPD. Ou é SPI ou é SI. Por quê? O posto não passa do número de equações, que é menor que n, então p < n sempre. Se for possível, sobram variáveis livres.

---

## Parte 7: Modelagem de problemas

A parte difícil na prática não é resolver, é **traduzir o problema pra sistema**. Receita: (1) dê nome às incógnitas, (2) ache as relações, (3) escreva uma equação por relação, (4) resolva, (5) interprete e confira.

### 7.1 Convencional: compras

Em uma papelaria, 2 cadernos e 3 canetas custam R$ 19,00. Um caderno e uma caneta juntos custam R$ 8,00. Quanto custa cada item?

Incógnitas: x = preço do caderno, y = preço da caneta.

```
2x + 3y = 19
 x +  y = 8
```

Da 2ª: x = 8 − y. Na 1ª: 2(8 − y) + 3y = 19 → 16 + y = 19 → **y = 3**, **x = 5**.

Caderno R$ 5,00 e caneta R$ 3,00. Conferindo: 10 + 9 = 19 ✓; 5 + 3 = 8 ✓.

### 7.2 Inusitado 1: balanceamento de reação química

Queimar propano (gás de cozinha): C₃H₈ + O₂ → CO₂ + H₂O. Preciso achar coeficientes inteiros a, b, c, d tais que:

```
a·C₃H₈ + b·O₂ → c·CO₂ + d·H₂O
```

O número de átomos de cada elemento tem que ser igual nos dois lados:

- Carbono: 3a = c → `3a − c = 0`
- Hidrogênio: 8a = 2d → `8a − 2d = 0`
- Oxigênio: 2b = 2c + d → `2b − 2c − d = 0`

Sistema **homogêneo** com 3 equações e 4 incógnitas. Pelo que vimos, tem de ser SPI (menos equações que incógnitas e homogêneo). Resolvendo em função de a = t:

- c = 3t
- d = 4t (de 8t = 2d)
- 2b = 2·3t + 4t = 10t → b = 5t

Solução geral: (t, 5t, 3t, 4t). Escolhendo o menor t inteiro (t = 1):

**C₃H₈ + 5 O₂ → 3 CO₂ + 4 H₂O.**

Aqui o SPI é a resposta certa: balancear é achar a proporção, e as infinitas soluções são múltiplos da mesma proporção (2C₃H₈ + 10O₂ → ... também vale, só é desnecessariamente grande).

### 7.3 Inusitado 2: passando uma parábola por três pontos

Qual parábola y = ax² + bx + c passa pelos pontos (0, 1), (1, 2) e (2, 5)? Cada ponto vira uma equação nas incógnitas a, b, c:

- (0, 1): a·0 + b·0 + c = 1 → `c = 1`
- (1, 2): a + b + c = 2
- (2, 5): 4a + 2b + c = 5

Com c = 1: `a + b = 1` e `4a + 2b = 4` (ou `2a + b = 2`). Subtraindo: a = 1, então b = 0.

**y = x² + 1.** Conferindo: em x = 2, y = 5 ✓.

Essa técnica (interpolação) é usada para desenhar curvas suaves em animações e gráficos de computador.

### 7.4 Outros lugares onde o sistema linear aparece

Circuitos elétricos (leis de Kirchhoff geram uma equação por nó e por malha), fluxo de trânsito em ruas (o que entra num cruzamento tem que sair), mistura de ligas ou soluções, planejamento de produção com recursos limitados, e redes neurais (que no fundo montam e resolvem sistemas gigantes).

---

## Parte 8: Erros comuns

1. **Multiplicar só um lado da equação** ao escalonar. A equação inteira (incluindo o termo independente) deve ser multiplicada.
2. **Multiplicar uma equação por zero** como "operação". Apaga a equação e destrói a equivalência.
3. **Conferir a solução nas equações já transformadas** em vez das originais. Se errou numa operação, a conferência "bate" e o erro passa.
4. **Dizer que D = 0 implica SPI.** Pode ser SI. Precisa analisar.
5. **Usar Cramer com D = 0.** Divide por zero. Não funciona.
6. **Ver `0 = 0` e achar que está tudo ótimo**, esquecendo de calcular as variáveis livres. Isso é SPI, a resposta é uma família de soluções.
7. **Ver `0 = 5` e continuar resolvendo.** Pare: é SI.
8. **Errar o sinal ao subtrair equações**, principalmente com coeficientes negativos. Escreva os cálculos linha por linha.
9. **Tratar equação não linear como linear.** `xy = 6` não vira sistema linear nem com esforço.
10. **Esquecer que sistema homogêneo nunca é SI**, e procurar contradição onde não existe.

---

## Parte 9: Para praticar

Tente antes de olhar o gabarito.

**1.** Quais destas equações são lineares? (a) `3x − 2y = 5`; (b) `x² + y = 1`; (c) `x/4 + y/3 = 2`; (d) `xy = 8`; (e) `2x + 0y = 6`.

**2.** Resolva por substituição: `3x + y = 11` e `x − 2y = 6`.

**3.** Resolva por escalonamento:
```
x + 2y + z = 8
2x − y + z = 3
3x + y − z = 2
```

**4.** Classifique e resolva (quando houver solução):
(a) `x − y + z = 2`, `2x + y − z = 1`, `3x = 3`
(b) `x − y + z = 2`, `2x + y − z = 1`, `3x = 4`

**5.** Discuta o sistema `kx + y = 1`, `x + ky = 1` em função de k.

**6.** Balanceie: Al + O₂ → Al₂O₃.

**7.** Para que valor de m o sistema homogêneo `x + 2y = 0`, `3x + my = 0` tem solução diferente da trivial?

**8.** Uma lanchonete vende combos. O combo A (2 hambúrgueres e 1 refrigerante) custa R$ 25,00. O combo B (1 hambúrguer e 2 refrigerantes) custa R$ 20,00. Quanto custa cada item?

### Gabarito

**1.** São lineares: (a), (c) e (e). (b) tem x², (d) é produto de incógnitas.

**2.** Isolando y na 1ª: y = 11 − 3x. Substituindo na 2ª: x − 2(11 − 3x) = 6 → x − 22 + 6x = 6 → 7x = 28 → **x = 4**, y = 11 − 12 = **−1**. Confere: 12 − 1 = 11 ✓; 4 + 2 = 6 ✓. Solução (4, −1).

**3.** `L₂ − 2L₁`: [0, −5, −1 | −13]. `L₃ − 3L₁`: [0, −5, −4 | −22]. `L₃ − L₂`: [0, 0, −3 | −9]. Então z = 3; −5y − 3 = −13 → y = 2; x + 4 + 3 = 8 → x = 1. **Solução (1, 2, 3), SPD.**

**4.** (a) A 3ª equação é a soma das duas primeiras (3x = 3), então é redundante. **SPI.** x = 1; da 1ª: −y + z = 1 → y = z − 1. Solução geral **(1, t − 1, t)**. (b) A soma das duas primeiras dá 3x = 3, mas a 3ª diz 3x = 4. Contradição, **SI.**

**5.** D = k² − 1 = (k − 1)(k + 1). **k ≠ 1 e k ≠ −1:** SPD. **k = 1:** as duas equações viram x + y = 1 (idênticas), **SPI**. **k = −1:** −x + y = 1 e x − y = 1; somando dá 0 = 2, **SI.**

**6.** a·Al + b·O₂ → c·Al₂O₃. Alumínio: a = 2c. Oxigênio: 2b = 3c. Com c = 2: a = 4, b = 3. **4 Al + 3 O₂ → 2 Al₂O₃.**

**7.** D = 1·m − 2·3 = m − 6 = 0 → **m = 6.**

**8.** x = hambúrguer, y = refrigerante: `2x + y = 25` e `x + 2y = 20`. Da primeira, y = 25 − 2x. Na segunda: x + 50 − 4x = 20 → −3x = −30 → **x = 10**, y = 5. **Hambúrguer R$ 10,00 e refrigerante R$ 5,00.** Confere: 20 + 5 = 25 ✓; 10 + 10 = 20 ✓.

---

## Síntese

- **Equação linear:** incógnitas só com expoente 1 e sem produto entre elas; geometricamente é reta (2 incógnitas) ou plano (3).
- **Sistema linear:** equações válidas ao mesmo tempo. Classificação: **SPD** (1 solução), **SPI** (infinitas) ou **SI** (nenhuma). Nunca existe um número intermediário de soluções.
- **Operações que preservam as soluções:** trocar equações, multiplicar por número ≠ 0, somar múltiplo de outra equação.
- **Escalonamento** resolve e classifica qualquer sistema: linha `0 = k` (k ≠ 0) é SI; linha `0 = 0` com variáveis sobrando é SPI; escada completa é SPD.
- **Cramer** resolve sistemas quadrados com D ≠ 0 e é a ferramenta natural para discutir parâmetros. D = 0 pode ser SPI ou SI.
- **Rouché-Capelli** classifica qualquer sistema comparando p(A), p(A|B) e n.
- Homogêneo sempre tem solução (a trivial).
- Modelar bem (dar nome às incógnitas, uma equação por relação) vale tanto quanto resolver.

### Para onde ir depois

- **Álgebra Linear:** espaço vetorial, base, dimensão, núcleo da matriz (o "conjunto solução" de um sistema homogêneo, visto de forma estruturada).
- **Métodos numéricos:** decomposição LU, método de Jacobi e Gauss-Seidel (como computadores resolvem sistemas com milhões de variáveis).
- **Programação linear:** inequações lineares e otimização, a versão "com desigualdade" deste tema, muito usada em logística e economia.
- **Prática em código:** `numpy.linalg.solve(A, B)` resolve sistema quadrado em uma linha. Vale testar com os exemplos desta apostila.

---

## Referências

Conteúdo conferido em mais de uma fonte; todos os sistemas dos exemplos foram resolvidos e verificados por métodos diferentes (escalonamento, Cramer e substituição das soluções nas equações originais).

- Preparaenem (Brasil Escola): Discussão de um sistema linear. https://www.preparaenem.com/matematica/discussao-um-sistema-linear.htm
- Preparaenem (Brasil Escola): Classificação de sistemas lineares escalonados. https://www.preparaenem.com/amp/matematica/classificacao-sistemas-lineares-escalonados.htm
- Toda Matéria: Escalonamento de sistemas lineares. https://www.todamateria.com.br/escalonamento-de-sistemas-lineares/
- Repositório UNESP: Matrizes no estudo e na resolução de sistemas lineares. https://repositorio.unesp.br/bitstreams/1b36b5e7-9ec1-46d1-9a9d-6858dcdefae1/download
- Revista Sigmae (UNIFAL-MG): Resolução de problemas e sistemas lineares no ensino médio. https://publicacoes.unifal-mg.edu.br/revistas/index.php/sigmae/article/download/608/476/2856
- Maurizio Cornalba (Univ. Pavia): Sistemi lineari, il teorema di Rouché-Capelli. https://mate.unipv.it/cornalba/dispense/alglin/rouche.pdf
- A ressalva sobre D = 0 (seção 5.3) corrige uma simplificação encontrada em alguns resumos online; as aplicações da seção 7.4 e as sugestões de continuação são conhecimento padrão da área, não vieram das fontes acima.
