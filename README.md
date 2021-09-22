# MC346
Paradigmas de programação 2s21

#
## Haskell

### Tarefa 1 - Trocatodos e cumsum

1) Implemente a função trocatodos que recebe o valor velho e o valor novo e uma lista e retorna a lista com todas as instancias de velho na lista trocada por novo.

2) implemente a função cumsum que dado uma lista de números retorna a lista com a soma cumulativa desses números. (na lista retornarda, a posição i contem a soma dos elementos da lista original até a posição i)

#

### Tarefa 2 - MergeSort

Implemente o mergesort em `haskellmergesort :: Ord a => [a] -> [a]`

Você pode usar as funções take, drop e length já definidas no Prelude. Provavelmente div (divisão inteira) será util. Voce pode definir outras funções auxiliares ou locais que quiser.

#

### Tarefa 3 - Letramaiscomum

`soma1`

Assuma que um contador é implementado como uma lista de tuplas onde o primeiro elemento da tupla é a chave e o segundo a contagem relativa a chave.
A função `soma1` implementada abaixo, dado uma chave e um contador (a lista) soma 1 na contagem relativa à chave no contador, ou inclui a chave na lista com contagem 1 se ela não tiver lista.

```
soma1 :: (Eq a) => a -> [(a,Int)] -> [(a,Int)]
soma1 ch [] = [(ch,1)]
soma1 ch ((a,n):ds)
| ch==a = (a,n+1):ds
| otherwise = (a,n):(soma1 ch ds)
```
`letramaiscomum`

Considere que letra é qualquer caracter que não o branco ( e coisas similares como o tab e o newline).

Implemente a função letramaiscomum que dado um string retorna a letra mais comum no string que não o branco/space. Considerar que letras maiúsculas e minúsculas contam como a mesma letra. Se duas ou mais letras tem a mesma contagem, sua função pode retornar qualquer uma dessas letras. Utilize alguma função de alto nivel: map, filter, fold, etc neste problema

funções talvez úteis que você pode usar se quiser:

`toLower :: Char -> Char` -> que se o argumento é uma letra maiúscula retorna a minúscula correspondente, e se for minúscula, retorna ela própria. Para usar o `toLower` use, `import Data.Char (toLower)` no seu programa

`isSpace :: Char -> Bool` -> que retorna `True` se o caracter um é tipo branco (Space, tab etc). É preciso importar essa função do `Data.Char`

`snd :: (a,b) -> b` -> retorna o 2º elemento de uma tupla de 2

`maximum :: Ord a => [a] -> a` retorna o maior elemento de uma lista. Verifique o que ele faz para lista de tuplas. Resposta: retorna a tupla com maior primeiro elemento, em caso de igualdade, retorna a tupla com maior segundo elemento entre os empatados

#

### Tarefa 4 - Compressão de listas

Dada a lista ( de caracteres)

`"aaabbaasxbbbb"`

Vamos definir uma lista comprimida cujos elementos são tuplas de dois elementos (item, quantidade), onde quantidade é o número de vezes que o item aparece sequenciamente na lista. Assim, a compressão dessa lista seria:

`[('a',3),('b',2),('a',2),('s',1),('x',1),('b',4)]`

Implemente a função `comprime :: Eq a => [a] -> [(a,Int)]`
```
comprime [3,3,3,4,5,6,5,5,5,5,7]
=> [(3,3),(4,1),(5,1),(6,1),(5,4),(7,1)]
```
Implemente a função descomprime que é o inverso de comprime
```
descomprime [(3,3),(4,1),(5,1),(6,1),(5,4),(7,1)]
==> [3,3,3,4,5,6,5,5,5,5,7]
```

#

### Tarefa 5 - Conta palavras e letras

Escreva um programa em haskell que lê do standard input um string (talvez contendo mudança de linhas dentro) e imprime o número de palavras no string e o número total de caracteres destas palavras.

Considere uma palavra como qualquer sequência de caracteres entre 2 brancos, ou entre branco e um `\n` ou entre dois `\n`.

Ex:
```
abc     def       ghi
jkl
mno pq
```

`abc` está entre o começo do arquivo e 1 branco, logo, é uma palavra

`def` está entre 2 brancos -> palavra

`jkl` está entre 2 `\n` -> palavra

etc.

O programa deve rodar como um programa executável. Se o arquivo com o seu programa chama-se tarefa5.hs ele sera executado como
```
ghc tarefa5.hs
./tarefa5 < entrada
```
ou
```
echo "string de entrada" | ./tarefa5
```

Essa são duas maneiras equivalentes de executar a tarefa.
- `entrada` é um arquivo que contem o string a ser processado; ou
- `string de entrada` é o string a ser processado
Ou seja, você precisa definir a função principal `main`.

#

### Projeto 1 - Contaminação numa rede de pessoas

Vamos assumir que nós temos uma rede de interação de pessoas representado por um grafo não direcionado com pesos. Cada pessoa é um nó/vértice no grafo e o peso da aresta entre o no A e B é a frequência ou intensidade de conexão entre A e B (por exemplo assuma que esse peso mede o némero de vezes no mês que A e B conversam).

Se uma membro do grafo é contaminado por um vírus, queremos determinar em quanto tempo todos os nós do grafo estarão contaminados. O tempo de contaminação entre A e B é o inverso da frequência de contato entre A e B (se A e B se falam 4 vezes for mês, o tempo de contaminação entre A e B é 1/4 ou 0.25 de um mês.

#### Algoritmo
Esse problema de encontrar o menor caminho de um vértice para todos os vértices de um grafo é conhecido como shortest-path tree. A solução é uma pequena variação do algoritmo de Dykstra. No Dykstra você tem a fonte e o destino, e constrói as estruturas de dados do algoritmo partindo da fonte e termina quando a fronteira atinge o destino. No caso do shortest-path tree você continua o algoritmo até que todos os vértices tenham sido visitados.

Veja que para esse problema nós não precisamos do caminho do nó origem a todos os outros nós. Precisamos apenas do tempo para a contaminação.

#### Formato dos dados

Os dados do programa serão no seguinte formato:

```
antonio beto 5.4
antonio denise 1.2
fabio edite  9.3
...
fabio zelia 4.5

antonio
```

As linhas como `antonio beto 5.4` indica que do nó `antonio` para o nó `beto` a frequência de contato é `5.4` (vezes por mês). Após todas as linhas do tipo acima, há uma linha em branco, e uma linha com o nome de um nó que é o nó contaminado.

Os dados serão lidos do `standard input`.

A saída deve ser no formato:

`3.14`

um número com 2 casas decimais que indica o tempo mínimo para que todos sejam contaminados.

Você pode assumir que o grafo é conectado, ou seja, existe um caminho entre quaisquer 2 nós do grafo.

Você não precisa usar estruturas de dados complexas como um “priority queue” que são `O(1)` para achar o mínimo. Pode fazer uma busca linear para achar o mínimo e usar as funções já disponíveis no Haskell.

Você não pode usar nenhum pacote do Haskel senão as bibliotecas padrão.

#
## Prolog

### Tarefa 6 - Vértice conectado

Suponha que nos temos um predicado `v(v1)` que indica que `v1` é um vértice num grafo e `a(v1,v2)` que indica que há uma aresta direcionada de `v1` para `v2`.

Defina o predicado `conectado(v1,v2)` se existe uma aresta entre `v1` e `v2` ou se existe uma sequência de arestas `a(v1,v3)`, `a(v3,v4)`, etc `a(vn,v2)`.