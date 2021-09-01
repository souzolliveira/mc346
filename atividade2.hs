-- take :: Int -> [a] -> [a]
-- drop :: Int -> [a] -> [a]
-- length :: Foldable t => t a -> Int
-- div :: Integral a => a -> a -> a

merge :: Ord a => [a] -> [a] -> [a]
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) = if x <= y 
                      then x:(merge xs (y:ys))
                      else y:(merge (x:xs) ys)

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort l = merge (mergeSort left) (mergeSort right)
              where left = take middle l
                    right = drop middle l
                    middle = length l `div` 2