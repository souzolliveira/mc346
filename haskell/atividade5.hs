printWordLength :: Int -> [String] -> IO ()
printWordLength 0 _ = return ()
printWordLength n words =
    do
        putStr (words!!(n-1))
        putStr ": "
        print (length (words!!(n-1)))
        printWordLength (n-1) words

charsTotal :: [String] -> [Int]
charsTotal = map length

main :: IO ()
main = do
    dados <- getContents
    putStr "Numero de palavras: "
    print (length (words dados))
    printWordLength (length (words dados)) (reverse (words dados))
    putStr "Total de caracteres: "
    print (sum (charsTotal (words dados)))
