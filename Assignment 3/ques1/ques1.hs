a = [2,3,5,11]  -- example input sets
b = [5,11, 13, 8] -- example input sets
c = [1, 2]  -- example input sets
d = [1, 2, 4] -- example input sets


-- function to find if the set is empty
nullset :: [Integer] -> Bool
nullset xs = null xs

-- Function to find union of two sets
unionset :: [Integer] -> [Integer] -> [Integer]
unionset xs ys = xs ++ [y | y <- ys, not (elem y xs)]

-- Function to find intersection of two sets
intersectionset :: [Integer] -> [Integer] -> [Integer]
intersectionset xs ys = [y | y <- ys, elem y xs]

-- Function to find subtraction of two sets
subtset :: [Integer] -> [Integer] -> [Integer]
subtset xs ys = [x | x <- xs, not (elem x ys)]

-- Function to find “Minkowski Sum' of two sets
sumset :: [Integer] -> [Integer] -> [Integer]
sumset [] [] = []
sumset [] ys = []
sumset xs [] = []
sumset xs (y:ys) = unionset [x + y | x <- xs] ds
  where ds = sumset xs ys