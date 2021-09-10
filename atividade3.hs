import Data.Char (toLower, isSpace)

soma1 :: (Eq a) => a -> [(a,Int)] -> [(a,Int)]
soma1 ch [] = [(ch,1)]
soma1 ch ((a,n):ds)
    | ch==a = (a,n+1):ds
    | otherwise = (a,n):soma1 ch ds

letramaiscomum :: [Char] -> Char
----------------------- 1 --- 2 ---------------------------------------------------------------------------- 3 ----- 4 -------------------- 5 ------------------------------------------------------------------------------
letramaiscomum string = fst (foldl (\ tupla x -> if snd x > snd tupla then x else tupla) tupla (drop 1 (foldl (\ soma x -> if not (isSpace x) then soma1 (toLower x) soma else soma1 ' ' soma) soma string)))
                        where tupla = (' ', 0)
                              soma = [(' ', 0)]
-- 1 - Pega o primeiro elemento da tupla retornada por 2
-- 2 - Retorna a tupla com maior segundo elemento
-- 3 - Remove o primeiro elemento da lista retornada por 4, que é o número de espaços encontrados
-- 4 - Percorre cada elemento da lista string validando por 5, iniciada pela tupla (' ', 0)
-- 5 - Condicional para verificar se o caracter não é um espaço, que chama o soma1 com o caracter ou chama o soma1 como espaço