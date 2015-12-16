{-
Name: Tien Ho
-}

double x    = x + x

quadruple x = double (double x)

sum []     = 0
sum (x:xs) = x + sum xs

product []     = 1
product (x:xs) = x * product xs

--Factorial of a positive integer
factorial n = product [1..n]

--Average of a list of integers
average ns = sum ns `div` length ns

--The revised script for exercise 3/Chapter 2
n = a `div` length xs
	where 
		a = 10
		xs = [1,2,3,4,5]

a = b + c
	where 
		b = 1
		c = 2
d = a * 2

--Two definitions for last that selects
--the last element of a nonempty list
last_1 xs = xs!!(length xs - 1)
last_2 xs = head (reverse xs)

--Two definitions for init that removes
--the last element of a nonempty list
init_1 xs = take (length xs - 1) xs
init_2 xs = reverse (tail (reverse xs))
