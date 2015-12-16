halve xs = splitAt n xs
		   where n = (length xs) `div` 2

safetail_1 xs = if null xs then [] else tail xs

safetail_2 xs | null xs    = []
              | otherwise  = tail xs

safetail_3 [] = []
safetail_3 xs = tail xs

pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

factors n = [x | x <- [1..n], n `mod` x == 0]
perfects n = [x | x <- [1..n], sum (init (factors x)) == x]

scalarproduct xs ys =  sum [x*y | (x,y) <- zip xs ys]
 
