:- module(writer,[helloMessage/0,goodbyeMessage/0]).

helloMessage:-
    write("Welcome to the Maze Solver!"),nl.

goodbyeMessage:-
    write("Thanks for Using the Maze Solver!"),nl.



replace(L, X, Y, Z, R):-
    append(RowPfx, [Row|RowSfx], L),
    length(RowPfx,X),
    append(ColPfx,[_|ColSfx],Row),
    length(ColPfx,Y),
    append(ColPfx,[Z|ColSfx],RowNew),
    append(RowPfx,[RowNew|RowSfx], R).
