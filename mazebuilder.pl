% TODO: Error handling

/* The run/1 predicate is the main entry point of the program. It reads the maze file,
 * prints it to the console, finds a path from the start to the end of the maze, and
 * replaces the path with 'X' characters in the printed maze. */
run(N):-
    read_file(N,List),
    printMaze(List),!,
    path(List, n(_,_,1,0), n(_,_,0,1), Path, [n(_,_,1,0)]),nl,  
    replace(List, Path, 'X',R).


/* The read_file/2 predicate opens a file, reads its contents line by line, and converts
 * each line into a list of integers. */
read_file(Filename, Rows) :-
    open(Filename, read, Stream),
    read_lines(Stream, Rows),
    close(Stream).

/* The read_lines/2 predicate is a helper predicate used by read_file/2. It reads each line of
 * the file and converts it to a list of integers. */
read_lines(Stream, []) :-
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

/* The path/5 predicate finds a path from the start node to the end node in the given maze.
 * It uses the e/3 predicate to check if two nodes are adjacent, and uses a list of visited
 * nodes to avoid infinite loops. */
path(_,Node,Node,[Node], [Node|_]).

path(Maze, StartNode, EndNode, [StartNode|Rest], Visited):-
    e(Maze, StartNode,NextNode),
    not(member(NextNode, Visited)),append([NextNode], Visited, NewVisited),
    path(Maze, NextNode,EndNode, Rest, NewVisited).

% The node/2 predicate finds the node with the given coordinates and type (start, end, or empty) in the maze.
node(Maze, n(X,Y,S,E)):-
    nth0(Y, Maze, Row),
    nth0(X, Row, N),
    (N is 1,S is 0,E is 0
    ;N is 8,S is 1,E is 0
    ;N is 9, S is 0,E is 1).

% The e/3 predicate checks if two nodes are adjacent.
e(Maze,n(X1,Y1,S1,E1),n(X2,Y2,S2,E2)):-
    node(Maze,n(X1,Y1,S1,E1)),node(Maze,n(X2,Y2,S2,E2)),n(X1,Y1,S1,E1) \= n(X2,Y2,S2,E2),
    (X1 = X2, (Y1 is Y2+1;Y1 is Y2-1);
     Y1 = Y2, (X1 is X2+1;X1 is X2-1)).

printMaze([]).
printMaze([H|T]):-
    printRow(H),nl,
    printMaze(T).

/* The printRow/1 predicate prints a row of the maze to the console. It takes a list
 * of integers as input, where each integer corresponds to a different type of maze cell.
 * It uses Prolog's built-in if-then-else construct to print the appropriate character
 * for each cell type, followed by a space character. */
printRow([]).
printRow([H|T]):-
    (H = 0,!,write('#');
    H = 8,!,write('S');
    H = 1,!,write(" ");
    H = 9,write('E');
    write('X')),
    write(" "),printRow(T).

/* The replace/4 predicate takes a maze, a list of nodes, a character to replace,
 * and outputs the modified maze with the nodes replaced by the character. */
replace(L,[],Z,L):-printMaze(L).
replace(L, [n(X,Y,S,E)|T], Z, R):-
    append(RowPfx, [Row|RowSfx], L),
    length(RowPfx,Y),
    append(ColPfx,[_|ColSfx],Row),
    length(ColPfx,X),
    append(ColPfx,[Z|ColSfx],RowNew),
    append(RowPfx,[RowNew|RowSfx], R),
    replace(R,T,Z,_).