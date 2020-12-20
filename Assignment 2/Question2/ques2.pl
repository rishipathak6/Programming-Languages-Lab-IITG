%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                              Question 3                              %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                 Data                                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bus (Number, Origin, Destination Place, Departure Time, Arrival Time, Distance, Cost)
bus(123,'Amingaon','Jalukbari',14.5,15,10,10).
bus(756,'Panbazar','Chandmari',16,16.5,7,8).
bus(561,'Jalukbari','Khoka', 16,10.5,3,5).
bus(408,'Amingaon','Khoka', 15,20.5,10,25).
bus(356,'Khoka','Chandmari', 22,11,9,6).
bus(216,'Khoka','Lokhra', 0,11,9,3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 1                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To find the optimal path, we need to find the path with smallest     %%%%%
%%%%% length. I find the length of a path recursively. Then I find the     %%%%%
%%%%% optimal path by comparing length by all other paths.                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Src, Dest, Path) :- path(Src, Dest, [], Path).
%%%%%                            End Condition                             %%%%%
path(Src, Src, _, [Src]).
%%%%%                           Main Recursion                             %%%%%
path(Src, Dest, Visited, [Src|Nodes]) :- not(member(Src, Visited)), dif(Src, Dest), [Next|_] = Nodes, bus(_,Src, Next, _,_,_,_), path(Next, Dest, [Src|Visited], Nodes).

%%%%%            Recursive function to calculate length of path            %%%%%
pathLength([Src,Next], Length, [BusNum]) :- bus(BusNum, Src, Next, _,_,Length,_).
pathLength([Src|Nodes], Length, [BusNum|BusNums]) :- [Next|_] = Nodes, bus(BusNum,Src, Next, _,_,Dist,_), pathLength(Nodes, RemPathLength, BusNums), Length is Dist + RemPathLength.

%%%%%                         Comparator function                          %%%%%
lengthComparator(Path,Path2) :- pathLength(Path2, PathLen2, _), pathLength(Path, PathLen1,_), PathLen2>=PathLen1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%             Caller function to get optimal distance path             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimalDistance(Src,Dest,Path, BusNums, Distance) :- path(Src,Dest, Path), forall(path(Src,Dest, Path2), lengthComparator(Path,Path2)), pathLength(Path, Distance, BusNums).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 3                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To find the optimal path, we need to find the path with smallest     %%%%%
%%%%% cost. I find the cost of a path recursively. Then I find the optimal %%%%%
%%%%% path by comparing cost of all other paths.                           %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%             Recursive function to calculate cost of path             %%%%%
pathCost([Src,Next], Cost, [BusNum]) :- bus(BusNum, Src, Next, _,_,_,Cost).
pathCost([Src|Nodes], Cost, [BusNum|BusNums]) :- [Next|_] = Nodes, bus(BusNum,Src, Next, _,_,_,EdgeCost), pathCost(Nodes, RemPathCost, BusNums), Cost is EdgeCost + RemPathCost.

%%%%%                         Comparator function                          %%%%%
costComparator(Path,Path2) :- pathCost(Path2, PathCost2, _), pathCost(Path, PathCost1,_), PathCost2>=PathCost1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Caller function to get optimal cost path               %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimalCost(Src,Dest,Path, BusNums, Cost) :- path(Src,Dest, Path), forall(path(Src,Dest, Path2), costComparator(Path,Path2)), pathCost(Path, Cost, BusNums).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 2                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To find the optimal path, we need to find the path with smallest     %%%%%
%%%%% time. I find the time of a path recursively considering different    %%%%%
%%%%% cases. Then I find the optimal path by comparing time of all other   %%%%%
%%%%% paths.                                                               %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%             Recursive function to calculate time of path             %%%%%
pathTime([Src|Nodes], Time, BusNum, ArrTimes) :- pathTime([Src|Nodes], Time, BusNum, [],ArrTimes).

pathTime([Src,Next], Time, [BusNum], [], [ArrTime]) :- bus(BusNum, Src, Next, DepTime, ArrTime,_,_),  (ArrTime - DepTime < 0 -> EdgeTime is ArrTime - DepTime + 24; EdgeTime is ArrTime - DepTime), Time is EdgeTime.

pathTime([Src,Next], Time, [BusNum], NewArrTimes, [ArrTime]) :- [PrevArrTime|_] = NewArrTimes, bus(BusNum, Src, Next, DepTime, ArrTime,_,_),  (ArrTime - DepTime < 0 -> EdgeTime is ArrTime - DepTime + 24; EdgeTime is ArrTime - DepTime), (DepTime - PrevArrTime < 0 -> WaitTime is DepTime - PrevArrTime + 24;  WaitTime is DepTime - PrevArrTime),Time is EdgeTime + WaitTime.

pathTime([Src|Nodes], Time, [BusNum|BusNums], [],[ArrTime|ArrTimes]) :- [Next|_] = Nodes,  bus(BusNum,Src, Next, DepTime, ArrTime,_,_), pathTime(Nodes, RemPathTime, BusNums, [ArrTime], ArrTimes), (ArrTime - DepTime < 0 -> EdgeTime is ArrTime - DepTime + 24; EdgeTime is ArrTime - DepTime), Time is EdgeTime + RemPathTime.

pathTime([Src|Nodes], Time, [BusNum|BusNums], NewArrTimes, [ArrTime|ArrTimes]) :- [Next|_] = Nodes, [PrevArrTime|_] = NewArrTimes, bus(BusNum,Src, Next, DepTime, ArrTime,_,_), pathTime(Nodes, RemPathTime, BusNums, [ArrTime|NewArrTimes], ArrTimes), (ArrTime - DepTime < 0 -> EdgeTime is ArrTime - DepTime + 24; EdgeTime is ArrTime - DepTime), (DepTime - PrevArrTime < 0 -> WaitTime is DepTime - PrevArrTime + 24;  WaitTime is DepTime - PrevArrTime),Time is EdgeTime + WaitTime + RemPathTime.

%%%%%                         Comparator function                          %%%%%
timeComparator(Path,Path2) :- pathTime(Path2, PathTime2, _,_), pathTime(Path, PathTime1,_,_), PathTime2>=PathTime1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%             Caller function to get optimal distance path             %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimalTime(Src,Dest,Path, BusNums, Time) :- path(Src,Dest, Path), forall(path(Src,Dest, Path2), timeComparator(Path,Path2)), pathTime(Path, Time, BusNums, _).
