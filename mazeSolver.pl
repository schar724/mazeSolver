%maze solver for prolog

:- use_module(writer).
:- use_module(graph).


run:-
    path([[1,1,1]], n(0,0),n(2,0), Path, [n(0,0)]),write(Path).

