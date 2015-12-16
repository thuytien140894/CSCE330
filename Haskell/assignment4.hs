pow m 0 = 1
pow m (n + 1) = m * (pow m n)

and' [] = True
and' (x:xs) = x && (and' xs)

concat' [] = []
concat' (x:xs) = x ++ (concat' xs)

replicate' 0 a = []
replicate' (n + 1) a = [a] ++ (replicate' n a)

select 0 (x:xs) = x
select (n + 1) (x:xs) = select n xs

elem' a [] = False
elem' a (x:xs) | a == x  = True
               | otherwise = elem' a xs

merge xs [] = xs
merge [] ys = ys
merge [] [] = []
merge (x:xs) (y:ys) | x <= y = [x] ++ (merge xs (y:ys))
                    | otherwise = [y] ++ (merge (x:xs) ys) 

halve xs = splitAt n xs
           where n = (length xs) `div` 2
msort [] = []
msort (x:[]) = [x]
msort xs = merge (msort as) (msort bs)  
		   where (as, bs) = halve xs 

sum' [] = 0
sum' (x:xs) = x + sum' xs

take' 0 _ = []
take' (n + 1) [] = [] 
take' (n + 1) (x:xs) = [x] ++ take n xs

last' [x] = x
last' (x:xs) = last' xs 
