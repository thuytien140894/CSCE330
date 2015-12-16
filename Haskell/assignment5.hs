import Data.Char

--convert an integer into a binary number
int2bin n = n `mod` 2 : int2bin (n `div` 2)

--convert a binary number into an integer
bin2int bits = sum [a*b | (a,b) <- zip weights bits]
               where weights = iterate (*2) 1

--truncate or extend a binary number to make it precisely eight bits
make8 bits = take 8 (bits ++ repeat 0)

--chop a list up into nine-bit binary numbers
chop9 [] = []
chop9 bits = take 9 bits : chop9 (drop 9 bits)

--extend each eight-bit binary number produced during encoding
--with a parity bit, set to 1 if the number contains an odd
--number of ones, and to 0 otherwise
setParityBit bits | odd (numberOf1s bits) = 1 : bits
                  | otherwise             = 0 : bits



--check each resulting nine-bit binary number consumed during
--decoding to ensure that its parity bit is correct
checkParityBit (x:xs) | x == 1 && odd (numberOf1s xs)  = xs
		              | x == 0 && even (numberOf1s xs) = xs
		              | otherwise                      = error "Parity error"

--count the number of 1s in an eight-bit binary number
numberOf1s [] = 0
numberOf1s (x:xs) | x == 1    = 1 + numberOf1s xs
		          | otherwise = numberOf1s xs

--a correct channel that preserves all the bits
channel = id

--encode a string into a binary sequence
encode string = concat (map (setParityBit . make8 . int2bin . ord) string)

--decode a binary sequence into a string
decode bits = map (chr . bin2int . checkParityBit) (chop9 bits)

--transmit a string to a binary sequence and then back to the string
transmit string = (decode . channel . encode) string
