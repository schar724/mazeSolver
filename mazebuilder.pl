% Takes in a file and returns a list of lists of integers
% TODO: Error handling
read_file(Filename, Rows) :-
    open(Filename, read, Stream),
    read_lines(Stream, Rows),
    close(Stream).

% Helper predicate that reads each line of the file and
% converts it to a list of integers
read_lines(Stream, []) :-
    % If the end of the file has been reached, stop reading
    at_end_of_stream(Stream).

read_lines(Stream, [Row|Rows]) :-
    % Read a line of the file as characters and turn them into character codes
    read_line_to_codes(Stream, Line),
    % Convert those codes to a list of integers
    atom_codes(Atom, Line),
    atomic_list_concat(Strings, ' ', Atom),
    maplist(atom_number, Strings, Row),
    % Read the next line of the file
    read_lines(Stream, Rows).
