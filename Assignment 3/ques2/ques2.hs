import Data.List
import System.Random

-- Put value of random seed between 1 and 479,001,600 for random permutation of teams
permut = 1000
teams = permutations["BS", "CM", "CH", "CV", "CS", "DS", "EE", "HU", "MA", "ME", "PH", "ST"]!!permut
-- pair even and odd occuring teams for knockout matches
teamtuples = zip [teams!!i | i<-[0,2..length teams-1]] [teams!!i | i<-[1,3..length teams-1]]
-- Tuples of possible date and time combinations in text and numbers
dayTimeNum = [(1, 9.5), (1, 19.5), (2, 9.5), (2, 19.5), (3, 9.5), (3, 19.5)]
datTimeText = [("1-12-20", "9:30"), ("1-12-20", "7:30"), ("2-12-20", "9:30"), ("2-12-20", "7:30"), ("3-12-20", "9:30"), ("3-12-20", "7:30")]

-- Print requirements
space = " "
tab = "        "
vs = "vs"

-- print a specific match details from i=0 to 5
match i = putStrLn (tab ++ fst (teamtuples!!i) ++ space ++ vs ++ space ++ snd (teamtuples!!i) ++ tab ++ fst (datTimeText!!i) ++ tab ++ snd (datTimeText!!i))

-- main fixture function
fixture :: String -> IO ()
fixture x
  | x == "all" = do -- If x = All the print full schedule
    match 0
    match 1
    match 2
    match 3
    match 4
    match 5
  | otherwise = do
    if x `elem` teams -- if x = team name then find its index and print its entry in schedule
      then match (index x 0 teams `div` 2)
    else
      print "Invalid Team Name"

-- Function for finding index of element in the list
index :: (Eq a) => a -> Int -> [a] -> Int
index y i xs
  | y == xs!!i = i
  | i == length xs = -1
  | otherwise = maxTail
    where maxTail = index y (i+1) xs

-- Function for finding next match after a date and time
nextMatch :: Int -> Float -> IO ()
nextMatch date time = do
  let p = ([ x | x <- [0..5], (date,time) <= (dayTimeNum!!x) ])
  if date < 1 || date > 3 then putStrLn "Date is not between 1st and 3rd December" -- Matches are scheduled between 1st and 3rd
  else if time < 0.0 || time >= 24.0 then putStrLn "Time is not between [0.0, 24.0)" -- Valid time 24hrs
  else if not (null p) then match (head p) -- Result
  else putStrLn "All matches done"