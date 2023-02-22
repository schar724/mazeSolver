:- module(graph, [path/4]).
:- use_module(library(assoc)).

e(Maze,n(X1,Y1),n(X2,Y2)):-
    node(Maze,n(X1,Y1)),node(Maze,n(X2,Y2)),n(X1,Y1) \= n(X2,Y2),
    (X1 = X2, (Y1 is Y2+1;Y1 is Y2-1);
     Y1 = Y2, (X1 is X2+1;X1 is X2-1)).

%When called, Visited must include a list with the startnode in it.
%ex) path(Maze,StartNode,EndNode,Path,[StartNode]) -> Where Maze is a 2D List and Start & End nodes are of the form n(X,Y).
%ex) path([[1,0,0,0,0],[1,1,0,0,0],[0,1,1,1,0],[0,1,0,1,0],[0,1,1,1,1]], n(0,0), n(4,4), Path, [n(0,0)]).

path(_,Node,Node,[Node], [Node|T]).

path(Maze, StartNode, EndNode, [StartNode|Rest], Visited):-
    e(Maze, StartNode,NextNode),
    not(member(NextNode, Visited)),append([NextNode], Visited, NewVisited),
    path(Maze, NextNode,EndNode, Rest, NewVisited).
    
node(Maze, n(X,Y)):-
    nth0(Y, Maze, Row),
    nth0(X, Row, 1).

if(Test,Then,Else):-
    Test,!,Then;
    Else.
