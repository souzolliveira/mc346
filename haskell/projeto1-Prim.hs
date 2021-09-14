-- 170442 - Emanuel Oliveira
-- 220650 - Lucas B. A. Farias
-- Para executar o programa:
-- 1. ghc .\projeto1.hs - Cria projeto.hi, projeto.o e projeto.exe
-- 2. Get-Content dados.txt | .\projeto1.exe - Executa projeto.exe com arquivo de entrada

-- imports
import Data.List ( nub )

-- funcoes auxiliares para o algortimo
primeiroElemento :: (a, a, b) -> a
primeiroElemento (a, b, c) = a
segundoElemento :: (a, a, b) -> a
segundoElemento (a, b, c) = b
terceiroElemento :: (a, a, b) -> b
terceiroElemento (a, b, c) = c

converteParaPegarMin :: (Eq a) => (a, a, b) -> (b, a, a)
converteParaPegarMin (a, b, c) = (c, b, a)

converteParaOriginal :: (Eq a) => (b, a, a) -> (a, a, b)
converteParaOriginal (a, b, c) = (c, b, a)

removeAresta :: (String, String, Double) -> [(String, String, Double)] -> [(String, String, Double)]
removeAresta _ [] = []
removeAresta (a, b, c) (x:xs)
    | primeiroElemento x == a && segundoElemento x == b = removeAresta (a, b, c) xs
    | otherwise = x:removeAresta (a, b, c) xs

adicionaVisitado :: String -> [String] -> [String]
adicionaVisitado item = foldr (:) [item]

removeNaoVisitado :: String -> [String] -> [String]
removeNaoVisitado _ [] = []
removeNaoVisitado item (x:xs)
    | x == item = removeNaoVisitado item xs
    | otherwise = x:removeNaoVisitado item xs

quemRemover :: [String] -> (String, String, Double) -> String
quemRemover naoVisitados tupla
    | primeiroElemento tupla `elem` naoVisitados = primeiroElemento tupla
    | otherwise = segundoElemento tupla

quemAdicionar :: [String] -> (String, String, Double) -> String
quemAdicionar visitados tupla
    | primeiroElemento tupla `notElem` visitados = primeiroElemento tupla
    | otherwise = segundoElemento tupla

criaNaoVisitados :: String -> [(String, String, Double)] -> [String] -> [String]
criaNaoVisitados infectado [] naoVisitados = naoVisitados
criaNaoVisitados infectado (x:xs) naoVisitados
    | primeiroElemento x /= infectado && primeiroElemento x `notElem` naoVisitados && (segundoElemento x == infectado || segundoElemento x `elem` naoVisitados) = criaNaoVisitados infectado xs (primeiroElemento x:naoVisitados)
    | segundoElemento x /= infectado && segundoElemento x `notElem` naoVisitados && (primeiroElemento x == infectado || primeiroElemento x `elem` naoVisitados) = criaNaoVisitados infectado xs (segundoElemento x:naoVisitados)
    | primeiroElemento x /= infectado && primeiroElemento x `notElem` naoVisitados && segundoElemento x /= infectado && segundoElemento x `notElem` naoVisitados = criaNaoVisitados infectado xs (primeiroElemento x:segundoElemento x:naoVisitados)
    | otherwise = criaNaoVisitados infectado xs naoVisitados

arestasNaoUtilizadas :: [(String, String, Double)] -> [String] -> [String] -> [(Double, String, String)]
arestasNaoUtilizadas [] _ _ = []
arestasNaoUtilizadas _ [] _ = []
arestasNaoUtilizadas _ _ [] = []
arestasNaoUtilizadas (x:xs) visitados naoVisitados
    | primeiroElemento x `elem` visitados && segundoElemento x `elem` naoVisitados || primeiroElemento x `elem` naoVisitados && segundoElemento x `elem` visitados = converteParaPegarMin x:arestasNaoUtilizadas xs visitados naoVisitados
    | otherwise = arestasNaoUtilizadas xs visitados naoVisitados

arestaDeMenorFrequenciaNaoUtilizada :: [(String, String, Double)] -> [String] -> [String] -> (String, String, Double)
arestaDeMenorFrequenciaNaoUtilizada pontos visitados naoVisitados = converteParaOriginal (minimum (arestasNaoUtilizadas pontos visitados naoVisitados))

-- algoritmo de Prim
prim :: [String] -> [String] -> Double -> [(String, String, Double)] -> Double
prim visitados [] soma pontos = soma
prim visitados naoVisitados soma pontos = prim (nub (adicionaVisitado (quemAdicionar visitados (arestaDeMenorFrequenciaNaoUtilizada pontos visitados naoVisitados)) visitados))
                                                      (removeNaoVisitado (quemRemover naoVisitados (arestaDeMenorFrequenciaNaoUtilizada pontos visitados naoVisitados)) naoVisitados)
                                                      (soma + terceiroElemento (arestaDeMenorFrequenciaNaoUtilizada pontos visitados naoVisitados))
                                                      (removeAresta (arestaDeMenorFrequenciaNaoUtilizada pontos visitados naoVisitados) pontos)

-- funcoes para leitura e manipulacao de dados da entrada
triplas :: [[String]] -> [(String, String, Double)]
------------------------------------ aqui pega a frequencia
triplas = map (\ x -> (head x, x!!1, 1 / (read (x!!2) :: Double)))

infectado :: [String] -> [String]
infectado lista = drop (length lista - 1) lista

converteEntrada :: String -> [(String, String, Double)]
converteEntrada entrada = triplas (map words (take (length (lines entrada) - 2) (lines entrada)))

-- main
main :: IO ()
main = do
    dados <- getContents
    print (prim (infectado (lines dados)) (criaNaoVisitados (head (infectado (lines dados))) (converteEntrada dados) []) 0.0 (converteEntrada dados))