-- find Cartesian products forming 2-tuple with dimensions of (bedroom, hall)
makeSet2 :: [a] -> [b] -> [(a, b)]
makeSet2 xs ys = [(x, y) | x <- xs, y <- ys]

-- find Cartesian products forming 3-tuple with dimensions of (bedroom, hall, kitchen)
makeSet3 :: [(a, b)] -> [c] -> [(a, b, c)]
makeSet3 xs ys = [(a, b, y) | (a, b) <- xs, y <- ys]

-- find Cartesian products forming 4-tuple with dimensions of (bedroom, hall, kitchen, bathroom)
makeSet4 :: [(a, b, c)] -> [d] -> [(a, b, c, d)]
makeSet4 xs ys = [(a, b, c, y) | (a, b, c) <- xs, y <- ys]

-- find Cartesian products forming 5-tuple with dimensions of (bedroom, hall, kitchen, bathroom, garden)
makeSet5 :: [(a, b, c, d)] -> [e] -> [(a, b, c, d, e)]
makeSet5 xs ys = [(a, b, c, d, y) | (a, b, c, d) <- xs, y <- ys]

-- find Cartesian products forming 6-tuple with dimensions of (bedroom, hall, kitchen, bathroom, garden, balcony)
makeSet6 :: [(a, b, c, d, e)] -> [f] -> [(a, b, c, d, e, f)]
makeSet6 xs ys = [(a, b, c, d, e, y) | (a, b, c, d, e) <- xs, y <- ys]

-- remove duplicate area dimensions from the list of 2-tuples
makeUnique2 :: (Eq a, Num a) => [((a, a), (a, a))] -> a -> a -> [((a, a), (a, a))]
makeUnique2 list = removeDuplicates2 list []

removeDuplicates2 :: (Eq a, Num a) => [((a, a), (a, a))] -> [a] -> a -> a -> [((a, a), (a, a))]
removeDuplicates2 [] _ _ _ = []
removeDuplicates2 ((a, b) : xs) list2 p q
  | ((uncurry (*) a * p) + (uncurry (*) b * q)) `elem` list2 = removeDuplicates2 xs list2 p q
  | otherwise = (a, b) : removeDuplicates2 xs (((uncurry (*) a * p) + (uncurry (*) b * q)) : list2) p q

-- remove duplicate area dimensions from the list of 3-tuples
makeUnique3 :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
makeUnique3 list = removeDuplicates3 list []

removeDuplicates3 :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
removeDuplicates3 [] _ _ _ _ = []
removeDuplicates3 ((a, b, c) : xs) list2 p q r
  | ((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r)) `elem` list2 = removeDuplicates3 xs list2 p q r
  | otherwise = (a, b, c) : removeDuplicates3 xs (((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r)) : list2) p q r

-- remove duplicate area dimensions from the list of 4-tuples
makeUnique4 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
makeUnique4 list = removeDuplicates4 list []

removeDuplicates4 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
removeDuplicates4 [] _ _ _ _ _ = []
removeDuplicates4 ((a, b, c, d) : xs) list2 p q r s
  | ((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s)) `elem` list2 = removeDuplicates4 xs list2 p q r s
  | otherwise = (a, b, c, d) : removeDuplicates4 xs (((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s)) : list2) p q r s

-- remove duplicate area dimensions from the list of 5-tuples
makeUnique5 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
makeUnique5 list = removeDuplicates5 list []

removeDuplicates5 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
removeDuplicates5 [] _ _ _ _ _ _ = []
removeDuplicates5 ((a, b, c, d, e) : xs) list2 p q r s t
  | ((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s) + (uncurry (*) e * t)) `elem` list2 = removeDuplicates5 xs list2 p q r s t
  | otherwise = (a, b, c, d, e) : removeDuplicates5 xs (((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s) + (uncurry (*) e * t)) : list2) p q r s t

-- remove duplicate area dimensions from the list of 6-tuples
makeUnique6 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
makeUnique6 list = removeDuplicates6 list []

removeDuplicates6 :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
removeDuplicates6 [] _ _ _ _ _ _ _ = []
removeDuplicates6 ((a, b, c, d, e, f) : xs) list2 p q r s t u
  | ((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s) + (uncurry (*) e * t) + (uncurry (*) f * u)) `elem` list2 = removeDuplicates6 xs list2 p q r s t u
  | otherwise = (a, b, c, d, e, f) : removeDuplicates6 xs (((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s) + (uncurry (*) e * t) + (uncurry (*) f * u)) : list2) p q r s t u

-- given smallest and largest dimension, get all possible dimensions
possibleDim :: (Eq a, Eq b, Num b, Num a) => (a, b) -> (a, b) -> [(a, b)]
possibleDim l h =
  if fst l == fst h
    then possibleDim2 l h
    else possibleDim2 l h ++ possibleDim lnew h
  where
    lnew = (fst l + 1, snd l)

possibleDim2 :: (Eq b, Num b) => (a1, b) -> (a2, b) -> [(a1, b)]
possibleDim2 l h =
  if snd l == snd h
    then [l]
    else l : possibleDim2 lnew h
  where
    lnew = (fst l, snd l + 1)

-- get maximum area possible
getAns :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
getAns = getMaxArea

getMaxArea :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
getMaxArea [] _ _ _ _ _ _ = 0
getMaxArea ((a, b, c, d, e, f) : xs) p q r s t u = maximum [((uncurry (*) a * p) + (uncurry (*) b * q) + (uncurry (*) c * r) + (uncurry (*) d * s) + (uncurry (*) e * t) + (uncurry (*) f * u)) :: Integer, getMaxArea xs p q r s t u]

--Main Display function
design :: Integer -> Integer -> Integer -> IO ()
design area bedroomCount hallCount = do
  -- Get all the possible dimensions of rooms
  let bedroomDim = possibleDim (10, 10) (15, 15)
  let hallDim = possibleDim (15, 10) (20, 15)
  let kitchenDim = possibleDim (7, 5) (15, 13)
  let bathroomDim = possibleDim (4, 5) (8, 9)
  let gardenDim = possibleDim (10, 10) (20, 20)
  let balconyDim = possibleDim (5, 5) (10, 10)

  -- Set the number of rooms based on the number of Hall and Bedroom count
  let kitchenCount = ceiling (fromIntegral bedroomCount / 3) :: Integer
  let bathroomCount = bedroomCount + 1
  let gardenCount = 1
  let balconyCount = 1

  -- List of unique (bedroom, hall)
  let list1 =
        makeUnique2
          ( filter
              ( \(a, b) ->
                  ( (uncurry (*) a * bedroomCount)
                      + uncurry (*) b * hallCount
                  )
                    <= area
              )
              (makeSet2 bedroomDim hallDim)
          )
          bedroomCount
          hallCount

  -- List of unique (bedroom, hall, kitchen)
  let list2 =
        makeUnique3
          ( filter
              ( \(a, b, c) -> -- remove duplicate areas
                  ( ( (uncurry (*) a * bedroomCount) -- area occupied by bedroom
                        + (uncurry (*) b * hallCount) -- area occupied by halls
                        + (uncurry (*) c * kitchenCount) -- area occupied by kitchens
                    )
                      <= area -- sum should be less than equal to given area
                  )
                    && ( fst c <= fst a && fst c <= fst b -- length of kitchen must not be larger than that of bedroom and hall
                           && snd c <= snd a
                           && snd c <= snd b -- breadth of kitchen must not be larger than that of bedroom and hall
                       )
              )
              (makeSet3 list1 kitchenDim) -- Cartesian product of dimensions
          )
          bedroomCount
          hallCount
          kitchenCount
  -- List of unique (bedroom, hall, kitchen, bathroom)
  let list3 =
        makeUnique4
          ( filter
              ( \(a, b, c, d) -> -- remove duplicate areas
                  ( ( (uncurry (*) a * bedroomCount) -- area occupied by bedroom
                        + (uncurry (*) b * hallCount) -- area occupied by halls
                        + (uncurry (*) c * kitchenCount) -- area occupied by kitchens
                        + (uncurry (*) d * bathroomCount) -- area occupied by bathrooms
                    )
                      <= area -- sum should be less than equal to given area
                  )
                    && (fst d <= fst c && snd d <= snd c) -- dimension of bathroom must not be larger than that of kitchen
              )
              (makeSet4 list2 bathroomDim) -- Cartesian product of dimensions
          )
          bedroomCount
          hallCount
          kitchenCount
          bathroomCount

  -- List of unique (bedroom, hall, kitchen, bathroom, garden)
  let list4 =
        makeUnique5
          ( filter
              ( \(a, b, c, d, e) -> -- remove duplicate areas
                  ( (uncurry (*) a * bedroomCount) -- area occupied by bedroom
                      + (uncurry (*) b * hallCount) -- area occupied by halls
                      + (uncurry (*) c * kitchenCount) -- area occupied by kitchens
                      + (uncurry (*) d * bathroomCount) -- area occupied by bathrooms
                      + (uncurry (*) e * gardenCount) -- area occupied by garden
                  )
                    <= area -- sum should be less than equal to given area
              ) -- Condition of sum
              (makeSet5 list3 gardenDim) -- Cartesian product of dimensions
          )
          bedroomCount
          hallCount
          kitchenCount
          bathroomCount
          gardenCount

  -- List of unique (bedroom, hall, kitchen, bathroom, garden, balcony)
  let list5 =
        makeUnique6
          ( filter
              ( \(a, b, c, d, e, f) ->
                  ( (uncurry (*) a * bedroomCount) -- area occupied by bedroom
                      + (uncurry (*) b * hallCount) -- area occupied by halls
                      + (uncurry (*) c * kitchenCount) -- area occupied by kitchens
                      + (uncurry (*) d * bathroomCount) -- area occupied by bathrooms
                      + (uncurry (*) e * gardenCount) -- area occupied by garden
                      + (uncurry (*) f * balconyCount) -- area occupied by balcony
                  )
                    <= area -- sum should be less than equal to given area
              )
              (makeSet6 list4 balconyDim)
          )
          bedroomCount
          hallCount
          kitchenCount
          bathroomCount
          gardenCount
          balconyCount -- remove duplicate areas

  -- calculate max area possible based on the number of rooms
  let maxArea = getAns list5 bedroomCount hallCount kitchenCount bathroomCount gardenCount balconyCount
  -- get the dimensions of rooms corresponding maximum area
  let result =
        filter
          ( \(a, b, c, d, e, f) ->
              (uncurry (*) a * bedroomCount)
                + (uncurry (*) b * hallCount)
                + (uncurry (*) c * kitchenCount)
                + (uncurry (*) d * bathroomCount)
                + (uncurry (*) e * gardenCount)
                + (uncurry (*) f * balconyCount)
                == maxArea
          )
          list5

  -- print result
  if null result
    then putStrLn "No possible design"
    else do
      let (a, b, c, d, e, f) = head result
      putStrLn $ "      Bedroom:      " ++ show bedroomCount ++ " (" ++ show (fst a) ++ " x " ++ show (snd a) ++ ")"
      putStrLn $ "      Hall:         " ++ show hallCount ++ " (" ++ show (fst b) ++ " x " ++ show (snd b) ++ ")"
      putStrLn $ "      Kitchen:      " ++ show kitchenCount ++ " (" ++ show (fst c) ++ " x " ++ show (snd c) ++ ")"
      putStrLn $ "      Bathroom:     " ++ show bathroomCount ++ " (" ++ show (fst d) ++ " x " ++ show (snd d) ++ ")"
      putStrLn $ "      Garden:       " ++ show gardenCount ++ " (" ++ show (fst e) ++ " x " ++ show (snd e) ++ ")"
      putStrLn $ "      Balcony:      " ++ show balconyCount ++ " (" ++ show (fst f) ++ " x " ++ show (snd f) ++ ")"
      putStrLn $ "      Unused Space: " ++ show (area - maxArea)