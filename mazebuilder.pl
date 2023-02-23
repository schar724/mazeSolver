% Takes in a file and returns a list of lists of integers
% TODO: Error handling


% run(N):-
%     read_file(N,List),,write(Path).
:- use_module(library(ansi_term)).

run(N):-
    read_file(N,List),
    printMaze(List),!,
    path(List, n(_,_,1,0), n(_,_,0,1), Path, [n(_,_,1,0)]),nl,  
    replace(List, Path, 'X',R).


read_file(Filename, Rows) :-
    open(Filename, read, Stream),
    read_lines(Stream, Rows),
    close(Stream).

% Helper predicate that reads each line of the file and
% converts it to a list of integers
read_lines(Stream, []) :-
    % If the end of the file has been reached, stop reading
    at_end_of_stream(Stream),!.

read_lines(Stream, [Row|Rows]) :-
    % Read a line of the file as characters and turn them into character codes
    read_line_to_codes(Stream, Line),
    % Convert those codes to a list of integers
    atom_codes(Atom, Line),
    atomic_list_concat(Strings, ' ', Atom),
    maplist(atom_number, Strings, Row),
    % Read the next line of the file
    read_lines(Stream, Rows).


path(_,Node,Node,[Node], [Node|_]).

path(Maze, StartNode, EndNode, [StartNode|Rest], Visited):-
    e(Maze, StartNode,NextNode),
    not(member(NextNode, Visited)),append([NextNode], Visited, NewVisited),
    path(Maze, NextNode,EndNode, Rest, NewVisited).
    
node(Maze, n(X,Y,S,E)):-
    nth0(Y, Maze, Row),
    nth0(X, Row, N),
    (N is 1,S is 0,E is 0
    ;N is 8,S is 1,E is 0
    ;N is 9, S is 0,E is 1).

e(Maze,n(X1,Y1,S1,E1),n(X2,Y2,S2,E2)):-
    node(Maze,n(X1,Y1,S1,E1)),node(Maze,n(X2,Y2,S2,E2)),n(X1,Y1,S1,E1) \= n(X2,Y2,S2,E2),
    (X1 = X2, (Y1 is Y2+1;Y1 is Y2-1);
     Y1 = Y2, (X1 is X2+1;X1 is X2-1)).

printMaze([]).
printMaze([H|T]):-
    printRow(H),nl,
    printMaze(T).

printRow([]).
printRow([H|T]):-
    (H = 0,!,write('#');
    H = 8,!,write('S');
    H = 1,!,write(" ");
    H = 9,write('E');
    write('X')),
    write(" "),printRow(T).

replace(L,[],Z,L):-printMaze(L).
replace(L, [n(X,Y,S,E)|T], Z, R):-
    append(RowPfx, [Row|RowSfx], L),
    length(RowPfx,Y),
    append(ColPfx,[_|ColSfx],Row),
    length(ColPfx,X),
    append(ColPfx,[Z|ColSfx],RowNew),
    append(RowPfx,[RowNew|RowSfx], R),
    replace(R,T,Z,_).