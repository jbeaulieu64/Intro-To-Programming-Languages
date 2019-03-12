-- This is the file where you should write your functions to turn in

-- Comments look like this. Please add comments to describe your code
removeElems::(Eq a) => a -> [a] -> [a]
removeElems _ [] = []
removeElems e (h:t)
                | e == h = (removeElems e t)
                | otherwise = h : (removeElems e t)

longerThan:: Int -> [[a]] -> [[a]]
longerThan _ [] = []
longerThan n l@(h:t) 
                | n <=0 = l
                | (length h) <= n = (longerThan n t)
                | otherwise = h : (longerThan n t)

printBar::[a] -> String
printBar [] = ""
printBar (_:t) = '*' : printBar t

sin'::(Num a, Fractional a) => a -> Int -> a 
sin' x n
        | n <= 0 = 0
        | n == 1 = (x - term)
        | even n = ((sin' x (n-1)) + term)
        | odd n =  ((sin' x (n-1)) - term)
        where pow = ((2 * n) + 1)
              dem = pow
              term = ((x^pow) / (fromIntegral (fact dem)))
              fact::Int -> Int
              fact 0 = 1
              fact n = n * (fact (n-1))
toAstro::Int -> Int -> String
toAstro m d
  |  m == 3 && d `elem` [21..31] || m == 4 && d `elem` [1..19] = "Aries" 
  |  m == 4 && d `elem` [20..31] || m == 5 && d `elem` [1..20] = "Taurus" 
  |  m == 5 && d `elem` [21..31] || m == 6 && d `elem` [1..21] = "Gemini"
  |  m == 6 && d `elem` [22..31] || m == 7 && d `elem` [1..22] = "Cancer"
  |  m == 7 && d `elem` [23..31] || m == 8 && d `elem` [1..22] = "Leo"
  |  m == 8 && d `elem` [23..31] || m == 9 && d `elem` [1..22] = "Virgo" 
  |  m == 9 && d `elem` [23..31] || m == 10 && d `elem`[1..22] = "Libra" 
  |  m == 10 && d`elem` [23..31] || m == 11 && d `elem`[1..21] = "Scorpio"
  |  m == 11 && d `elem` [22..31] || m == 12 && d `elem` [1..21] = "Sagittarius"
  |  m == 12 && d `elem` [22..31] || m == 1 && d `elem` [1..19] = "Capricorn"
  |  m == 1 && d `elem` [20..31] || m == 2 && d `elem` [1..18] = "Aquarius" 
  |  m == 2 && d `elem` [19..31] || m == 3 && d `elem` [1..20] = "Pisces" 

     





