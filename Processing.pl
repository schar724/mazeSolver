:- module(processing, [path/5]).

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
