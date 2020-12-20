% set_prolog_flag(answer_write_options,[max_depth(0)]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                              Question 3                              %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                 Data                                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
edge(g1,g5,4).
edge(g5,g1,4).

edge(g2,g5,6).
edge(g5,g2,6).

edge(g3,g5,8).
edge(g5,g3,8).

edge(g4,g5,9).
edge(g5,g4,9).


edge(g1,g6,10).
edge(g6,g1,10).

edge(g2,g6,9).
edge(g6,g2,9).

edge(g3,g6,3).
edge(g6,g3,3).

edge(g4,g6,5).
edge(g6,g4,5).


edge(g5,g7,3).
edge(g7,g5,3).

edge(g5,g10,4).
edge(g10,g5,4).

edge(g5,g11,6).
edge(g11,g5,6).

edge(g5,g12,7).
edge(g12,g5,7).

edge(g5,g6,7).
edge(g6,g5,7).

edge(g5,g8,9).
edge(g8,g5,9).


edge(g6,g8,2).
edge(g8,g6,2).

edge(g6,g12,3).
edge(g12,g6,3).

edge(g6,g11,5).
edge(g11,g6,5).

edge(g6,g10,9).
edge(g10,g6,9).

edge(g6,g7,10).
edge(g7,g6,10).


edge(g7,g10,2).
edge(g10,g7,2).

edge(g7,g11,5).
edge(g11,g7,5).

edge(g7,g12,7).
edge(g12,g7,7).

edge(g7,g8,10).
edge(g8,g7,10).


edge(g8,g9,3).
edge(g9,g8,3).

edge(g8,g12,3).
edge(g12,g8,3).

edge(g8,g11,4).
edge(g11,g8,4).

edge(g8,g10,8).
edge(g10,g8,8).


edge(g10,g15,5).
edge(g15,g10,5).

edge(g10,g11,2).
edge(g11,g10,2).

edge(g10,g12,5).
edge(g12,g10,5).


edge(g11,g15,4).
edge(g15,g11,4).

edge(g11,g13,5).
edge(g13,g11,5).

edge(g11,g12,4).
edge(g12,g11,4).


edge(g12,g13,7).
edge(g13,g12,7).

edge(g12,g14,8).
edge(g14,g12,8).

edge(g15,g13,3).
edge(g13,g15,3).

edge(g13,g14,4).
edge(g14,g13,4).

edge(g14,g17,5).
edge(g17,g14,5).

edge(g14,g18,4).
edge(g18,g14,4).

edge(g17,g18,8).
edge(g18,g17,8).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 1                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To find all the possible paths, we need to find the paths starting   %%%%%
%%%%% from g1, g2, g3 and g4 and ending at g17. I have done DFS here,      %%%%%
%%%%% using two sets, one that tracks the visited gates and another as the %%%%%
%%%%% unvisited gates. To end the loop, I check if start and dest gates    %%%%%
%%%%% are same and queue has only start gate.                              %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Src, Dest, Path) :- path(Src, Dest, [], Path).
%%%%%                            End Condition                             %%%%%
path(Src, Src, _, [Src]).
%%%%%                           Main Recursion                             %%%%%
path(Src, Dest, Visited, [Src|Nodes]) :- not(member(Src, Visited)), dif(Src, Dest), [Next|_] = Nodes, edge(Src, Next, _), path(Next, Dest, [Src|Visited], Nodes).

%%%%%              Caller function to get all possible paths               %%%%%
allPossible(Path) :- path(g1, g17, Path), member(g17, Path); path(g2, g17, Path), member(g17, Path); path(g3, g17, Path), member(g17, Path); path(g4, g17, Path), member(g17, Path).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 2                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To find the optimal path, we need to find the path with smallest     %%%%%
%%%%% length. I find the length of a path recursively. Then I find the     %%%%%
%%%%% optimal path by comparing length by all other paths.                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%            Recursive function to calculate length of path            %%%%%
pathLength([Src,Next], Length) :- edge(Src,Next,Length).
pathLength([Src|Nodes], Length) :- [Next|_] = Nodes, edge(Src,Next,Dist), pathLength(Nodes, RemPathLength), Length is Dist + RemPathLength.

%%%%%                         Comparator function                          %%%%%
comparator(Path,Path2) :- pathLength(Path2, PathLen2), pathLength(Path, PathLen1), PathLen2>=PathLen1.
%%%%%                 Caller function to get optimal path                  %%%%%
optimal(Path) :- allPossible(Path), forall(allPossible(Path2), comparator(Path,Path2)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                Part 3                                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% To validate a given path, we need to check if it starts from one of  %%%%%
%%%%% (g1, g2, g3, g4) and end on g17. Also we need to check if there is   %%%%%
%%%%% an edge between consecutive gates given in the path. So I did it by  %%%%%
%%%%% making a recursive function to check validity of path.               %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%                            End Condition                             %%%%%
validPath([g17], g17).

%%%%%    Recursive function for checking edge between consecutive gates    %%%%%
validPath([Src|Nodes], Dest) :- [Next|_] = Nodes, edge(Src, Next, _), validPath(Nodes, Dest).
validPath([Src|Nodes], Dest) :- [Next|_] = Nodes, edge(Next, Src, _), validPath(Nodes, Dest).

%%%%%               Caller function to check validity of path              %%%%%
valid([Src|Nodes]) :- member(Src, [g1, g2, g3, g4]), validPath([Src|Nodes], Dest), Dest = g17.
