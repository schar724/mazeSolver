:- use_module(input).
:- use_module(processing).
:- use_module(output).

run(N):-
    input:read_file(N,List),
    output:printMaze(List),!,
    processing:path(List, n(_,_,1,0), n(_,_,0,1), Path, [n(_,_,1,0)]),nl,  
    output:replace(List, Path, 'X',_).