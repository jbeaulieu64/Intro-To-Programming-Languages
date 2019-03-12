-- This is the file where you should write your functions to turn in

-- Comments look like this. Please add comments to describe your code

add_and_triple x y = (x+y)*3
x +* y = add_and_triple x y
triangular_numbers n = [ n * (n + 1) `div` 2 | n <- [1..n] ]