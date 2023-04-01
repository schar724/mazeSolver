:- module(input, [read_file/2]).

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