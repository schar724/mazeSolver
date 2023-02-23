%maze solver for prolog

:- use_module(writer).
:- use_module(graph).
:- use_module(mazebuilder).


run(N):-
    read_file(N, List), path(List, n(1,1), n(4,6), Path, [n(1,1)]),write(Path).

