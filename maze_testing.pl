:- consult(main).

:- begin_tests(main).

test(one_path, [nondet]) :-
    nl,
    run('tests/simple_path_rest_walls.txt'),
    nl.

test(perfect_maze,[nondet]) :-
    nl,nl,
    run('tests/perfect_maze.txt'),
    nl.

test(cycle_path, [forall(run('tests/one_cycle_rest_walls.txt'))]) :-
    nl.

test(multi_path, [forall(run('tests/imperfect_maze_multiple_soln.txt'))]) :-
    nl.

test(imperfect_maze, [nondet]) :-
    nl,
    run('tests/imperfect_maze.txt'),
    nl.

test(no_exit, [fail]) :-
    nl,
    run('tests/no_exit.txt'),
    nl.

test(empty_file, [fail]) :-
    nl,
    run('tests/empty_file.txt'),
    nl.

test(all_walls_no_s_or_e, [fail]) :-
    nl,
    run('tests/all_walls_no_s_or_e.txt'),
    nl.

test(all_paths_no_s_or_e, [fail]) :-
    nl,
    run('tests/all_paths_no_s_or_e.txt'),
    nl.

test(multiple_exits, [nondet]) :-
    nl,
    run('tests/multiple_exits.txt'),
    nl.

/* test(test8, [forall(run('tests/multiple_exits.txt'))]) :-
    nl.*/

test(adjacent_s_and_e, [nondet]) :-
    nl,
    run('tests/adjacent_s_and_e.txt'),
    nl.

test(smaller_dims, [nondet]) :-
    nl,
    run('tests/smaller_dims.txt'),
    nl.

test(rectangle_no_path, [fail]) :-
    nl,
    run('tests/rectangle_no_path.txt'),
    nl.

test(illegal_char, [fail]) :-
    nl,
    run('tests/illegal_char.txt'),
    nl.

test(file_not_found, [fail]) :-
    nl,
    run('does_not_exist.txt').

:- end_tests(main).