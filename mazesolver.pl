/* The run/1 predicate is the main entry point of the program. It reads the maze file,
   prints it to the console, finds a path from the start to the end of the maze, and
   replaces the path with 'X' characters in the printed maze. */
run(N):-
    read_file(N,List),
    printMaze(List),!,
    path(List, n(_,_,1,0), n(_,_,0,1), Path, [n(_,_,1,0)]),nl,  
    replace(List, Path, 'X',_).


/* The read_file/2 predicate opens a file, reads its contents line by line, and converts
   each line into a list of integers. */
read_file(Filename, Rows) :-
catch(
    open(Filename, read, Stream), error(existence_error(_, _), _), (
            write('Error: Could not open file.'),
            fail
            )),
    read_lines(Stream, Rows),
    close(Stream).

/* The read_lines/2 predicate is a helper predicate used by read_file/2. It reads each line of
   the file and converts it to a list of integers. */
read_lines(Stream, []) :-
    at_end_of_stream(Stream),!.

read_lines(Stream, [Row|Rows]) :-
    
    read_line_to_codes(Stream, Line),       % Read a line of the file as characters and turn them into character codes
    atom_codes(Atom, Line),                 % Convert those codes to a list of integers
    atomic_list_concat(Strings, ' ', Atom),
    catch(
       maplist(parse_int, Strings, Row),
        error(existence_error(_, _), _),
        (
            write('Error: Invalid symbol in file'),
            nl,
            fail
        )),
    read_lines(Stream, Rows).

parse_int(String, Int) :-
    atom_number(String, Int),
    (Int =:= 0 ; Int =:= 1 ; Int =:= 8 ; Int =:= 9), !.

parse_int(_, _) :-
    throw(error(existence_error(_, _), _)).

/* The path/5 predicate finds a path from the start node to the end node in the given maze.
   It uses the e/3 predicate to check if two nodes are adjacent, and uses a list of visited
   nodes to avoid infinite loops. */
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