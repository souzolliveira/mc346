comprime :: Eq a => [a] -> [(a, Int)]
comprime lista = foldl soma [] (reverse lista)
                 where soma :: (Eq a) => [(a, Int)] -> a -> [(a, Int)]
                       soma [] ch = [(ch,1)]
                       soma ((c, q): ds) ch
                        | ch == c = (c, q + 1):ds
                        | otherwise = (ch, 1):(c, q):ds

descomprime :: Eq a => [(a, Int)] -> [a]
descomprime = concatMap (\ (c, q) -> replicate q c)

-- replicate :: Int -> a -> [a]
-- concatMap :: Foldable t => (a -> [b]) -> t a -> [b]