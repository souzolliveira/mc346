# mc346
Paradigmas de programação 2s21

## Tarefa 1 - Trocatodos e cumsum

1) Implemente a função trocatodos que recebe o valor velho e o valor novo e uma lista e retorna a lista com todas as instancias de velho na lista trocada por novo.

2) implemente a função cumsum que dado uma lista de números retorna a lista com a soma cumulativa desses números. (na lista retornarda, a posição i contem a soma dos elementos da lista original até a posição i)

## Tarefa 2 - MergeSort

Implemente o mergesort em `haskellmergesort :: Ord a => [a] -> [a]`

Você pode usar as funções take, drop e length já definidas no Prelude. Provavelmente div (divisão inteira) será util. Voce pode definir outras funções auxiliares ou locais que quiser.

## Tarefa 3 - Letramaiscomum

`soma1`

Assuma que um contador é implementado como uma lista de tuplas onde o primeiro elemento da tupla é a chave e o segundo a contagem relativa a chave.
A função `soma1` implementada abaixo, dado uma chave e um contador (a lista) soma 1 na contagem relativa à chave no contador, ou inclui a chave na lista com contagem 1 se ela não tiver lista.

```soma1 :: (Eq a) => a -> [(a,Int)] -> [(a,Int)]

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