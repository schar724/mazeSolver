:- consult(mazebuilder).

:- begin_tests(mazesolver).

test(one_path, [nondet]) :-
    nl,
    run('test0.txt'),
    nl.

test(donut_path, [forall(run('test1.txt'))]) :-
    nl.

test(multi_path, [forall(run('test2.txt'))]) :-
    nl.

test(test3, [nondet]) :-
    nl,
    run('test3.txt'),
    nl.

test(test4, [fail]) :-
    nl,
    run('test4.txt'),
    nl.

test(test5, [fail]) :-
    nl,
    run('test5.txt'),
    nl.

test(test6, [fail]) :-
    nl,
    run('test6.txt'),
    nl.

test(test7, [fail]) :-
    nl,
    run('test7.txt'),
    nl.

test(test8, [nondet]) :-
    nl,
    run('test8.txt'),
    nl.

/*test(test8, [forall(run('test8.txt'))]) :-
    nl.*/

test(test9, [nondet]) :-
    nl,
    run('test9.txt'),
    nl.

test(test10, [nondet]) :-
    nl,
    run('test10.txt'),
    nl.

test(test11, [fail]) :-
    nl,
    run('test11.txt'),
    nl.

test(file_fail, [fail]) :-
    nl,
    run('test12.txt'),
    nl.

test(file_not_found, [fail]) :-
    nl,
    run('test.txt').

:- end_tests(mazesolver).