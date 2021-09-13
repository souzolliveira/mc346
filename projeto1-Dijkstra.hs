-- 170442 - Emanuel Oliveira
-- 220650 - Lucas B. A. Farias
-- Para executar o programa:
-- 1. ghc .\projeto1.hs - Cria projeto.hi, projeto.o e projeto.exe
-- 2. Get-Content dados.txt | .\projeto1.exe - Executa projeto.exe com arquivo de entrada

-- funcoes auxiliares para o algortimo
tiraPessoa :: Eq a => a -> [a] -> [a]
tiraPessoa pessoa [] = []
tiraPessoa pessoa (x:xs)
    | x == pessoa = xs
    | otherwise = x: tiraPessoa pessoa xs

criaListaDePessoas :: Eq a => a -> [(a,a,Double)] -> [a] -> [a]
criaListaDePessoas infectado [] resp = resp
criaListaDePessoas infectado ((p1,p2,f):ds) resp
    | (p1 /= infectado) && p1 `notElem` resp && ((p2 == infectado) || (p2 `elem` resp)) = criaListaDePessoas infectado ds (p1:resp)
    | (p2 /= infectado) && p2 `notElem` resp && ((p1 == infectado) || (p1 `elem` resp)) = criaListaDePessoas infectado ds (p2:resp)
    | (p1 /= infectado) && p1 `notElem` resp && (p2 /= infectado) && (p2 `notElem` resp) = criaListaDePessoas infectado ds (p1:p2:resp)
    | otherwise = criaListaDePessoas infectado ds resp

-- algoritmo de Dijkstra
tempoContaminacao :: Eq a => a -> [(a,a,Double)] -> [a] -> [a] -> [Double]
tempoContaminacao infectado [] pessoas pessoasConst = []
tempoContaminacao infectado relacoes [] pessoasConst = []
tempoContaminacao infectado relacoes (x:xs) pessoasConst = mc: tempoContaminacao infectado relacoes xs pessoasConst
    where mc = minimum (caminhos infectado x relacoes relacoes pessoasConst 0.0 [])

caminhos :: Eq a => a -> a -> [(a,a,Double)] -> [(a,a,Double)] -> [a] -> Double -> [Double] -> [Double]
caminhos infectado destino [] relacoes pessoas tempo resposta = []
caminhos infectado destino ((p1,p2,f):ds) relacoes pessoas tempo resposta
    | parCorreto = (tempo + f): caminhos infectado destino ds relacoes pessoas tempo ((tempo + f): resposta)
    | (p1 == infectado) && (p2 `elem` pessoas) = caminhos p2 destino relacoes relacoes (tiraPessoa p1 pessoas) (tempo + f) resposta ++ caminhos infectado destino ds relacoes pessoas tempo resposta
    | (p2 == infectado) && (p1 `elem` pessoas) = caminhos p1 destino relacoes relacoes (tiraPessoa p2 pessoas) (tempo + f) resposta ++ caminhos infectado destino ds relacoes pessoas tempo resposta
    | otherwise = caminhos infectado destino ds relacoes pessoas tempo resposta
    where parCorreto = ((p1 == infectado) && (p2 == destino)) || ((p2 == infectado) && (p1 == destino))

-- funcoes para leitura e manipulacao de dados da entrada
triplas :: [[String]] -> [(String, String, Double)]
------------------------------------ aqui pega a frequencia
triplas = map (\ x -> (head x, x!!1, 1 / (read (x!!2) :: Double)))

infectado :: [String] -> String
infectado lista = head (drop (length lista - 1) lista)

converteEntrada :: String -> [(String, String, Double)]
converteEntrada entrada = triplas (map words (take (length (lines entrada) - 2) (lines entrada)))

processar :: String -> [Double]
processar entrada = tempoContaminacao (infectado (lines entrada)) (converteEntrada entrada) (criaListaDePessoas (infectado (lines entrada)) (converteEntrada entrada) []) (criaListaDePessoas (infectado (lines entrada)) (converteEntrada entrada) [])

-- main
main :: IO ()
main = do
    dados <- getContents
    print (maximum (processar dados))