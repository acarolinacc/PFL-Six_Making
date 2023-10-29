initialBoard([
    [empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty]
]).

% Define the symbols for each player.
symbol(empty, ' ').
symbol(black, 'X').
symbol(white, 'O').

% Define a predicate to convert row numbers to letters.
letter(1, '1').
letter(2, '2').
letter(3, '3').
letter(4, '4').
letter(5, '5').

% Print the game board.
printBoard(Board) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 |\n'),
    write('---|---|---|---|---|---|\n'),
    printMatrix(Board, 1).

% Print the matrix, including row numbers.
printMatrix([], 6).
printMatrix([Row|Rest], N) :-
    letter(N, L),
    format(' ~w | ', [L]),
    printRow(Row),
    write('\n---|---|---|---|---|---|\n'),
    N1 is N + 1,
    printMatrix(Rest, N1).

% Print a single row.
printRow([]).
printRow([Cell|Rest]) :-
    symbol(Cell, S),
    format('~w | ', [S]),
    printRow(Rest).
