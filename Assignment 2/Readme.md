## How to execute Question 1

- Open SWI-Prolog and consult Ques1.pl
- To test part1(uncle), input query in the format: uncle(X,Y). Example - `uncle(katappa,A).`
- To test part2(halfsister), input query in the format: halfsister(X,Y). Example - `halfsister(A, shivkami).`

## How to execute Question 2

- Open SWI-Prolog and consult Ques2.pl
- To test part1(distance), input query in the format: optimalDistance(Src,Dest,Path, BusNums, Distance). Example - `optimalDistance('Amingaon', 'Lokhra',Path, BusNums, Distance).`
- To test part2(time), input query in the format: optimalTime(Src,Dest,Path, BusNums, Time). Example - `optimalTime('Amingaon', 'Lokhra',Path, BusNums, Time).`
- To test part3(cost), input query in the format: optimalCost(Src,Dest,Path, BusNums, Cost). Example - `optimalCost('Amingaon', 'Lokhra',Path, BusNums, Cost).`

## How to execute Question 3

- Open SWI-Prolog and consult Ques3.pl
- Run `set_prolog_flag(answer_write_options,[max_depth(0)]).` It enables us to see long lists completely else lists will be shown truncated.
- To test part1(all possible paths), input query in the format: `allPossible(Path).`
- To test part2(optimal path), input query in the format: `optimal(Path).`
- To test part3(valid or invalid path), input query in the format: valid([Src|Nodes]). Example - `valid([g1, g6, g8, g9, g8, g7, g10, g15, g13, g14, g18, g1`
