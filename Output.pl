:- module(output, [printMaze/1, replace/4]).

printMaze([]).
printMaze([H|T]):-
    printRow(H),nl,
    printMaze(T).

/* The printRow/1 predicate prints a row of the maze to the console. It takes a list
   of integers as input, where each integer corresponds to a different type of maze cell.
   It uses Prolog's built-in if-then-else construct to print the appropriate character
   for each cell type, followed by a space character. */
printRow([]).
printRow([H|T]):-
    (H = 0,!,write('#');
    H = 8,!,write('S');
    H = 1,!,write(" ");
    H = 9,write('E');
    ansi_format([fg(green)], '~w', ['X'])),
    write(" "),printRow(T).

/* The replace/4 predicate takes a maze, a list of nodes, a character to replace,
   and outputs the modified maze with the nodes replaced by the character. 
   modified from https://github.com/ProjetoAplp/resta1-prolog/blob/master/resta1.pl */
replace(L,[],_,L):-printMaze(L).
replace(L, [n(X,Y,_,_)|T], Z, R):-
    append(RowPfx, [Row|RowSfx], L),    % decompose the list-of-lists into a prefix, a list and a suffix
    length(RowPfx,Y),                   % check the prefix length: do we have the desired list?
    append(ColPfx,[_|ColSfx],Row),      % decompose that row into a prefix, a column and a suffix
    length(ColPfx,X),                   % check the prefix length: do we have the desired column?
    append(ColPfx,[Z|ColSfx],RowNew),   % if so, replace the column with its new value
    append(RowPfx,[RowNew|RowSfx], R),  % and assemble the transformed list-of-lists
    replace(R,T,Z,_).