trocatodos _ _ [] = []
trocatodos v n (x:xs) 
  | x == v = n:trocatodos v n xs
  | otherwise = x:trocatodos v n xs

soma a (x:xs) = x+a:xs

cumsum [] = []
cumsum [x] = [x]
cumsum (x:xs) = x:cumsum(soma x xs)