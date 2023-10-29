% Replace an element in a list at a specified index.
replaceInList([_|T], 0, Value, [Value|T]) :- !.
replaceInList([H|T], Index, Value, [H|TNew]) :-
    Index > 0,
    Index1 is Index - 1,
    replaceInList(T, Index1, Value, TNew).

% Replace an element in a matrix at a specified row and column.
replaceInMatrix([H|T], 0, Column, Value, [HNew|T]) :-
    replaceInList(H, Column, Value, HNew).
replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
    Row > 0,
    Row1 is Row - 1,
    replaceInMatrix(T, Row1, Column, Value, TNew).

% Get the value from a list at a specified index.
getValueFromList([H|_], 0, H).
getValueFromList([_|T], Index, Value) :-
    Index > 0,
    Index1 is Index - 1,
    getValueFromList(T, Index1, Value).

% Get the value from a matrix at a specified row and column.
getValueFromMatrix([H|_], 0, Column, Value) :-
    getValueFromList(H, Column, Value).
getValueFromMatrix([_|T], Row, Column, Value) :-
    Row > 0,
    Row1 is Row - 1,
    getValueFromMatrix(T, Row1, Column, Value).

% Find the row and column positions of a specific value in the matrix.
findPositionInColumn([], _, _, _, _).
findPositionInColumn([Value|T], Value, Row, Column, Result) :-
    Row = Result,
    Column = 0.
findPositionInColumn([_|T], Value, Row, Column, Result) :-
    Column1 is Column + 1,
    findPositionInColumn(T, Value, Row, Column1, Result).
findPositionInRow([], _, _, _, _).
findPositionInRow([Row|T], Value, RowIndex, Result, Column) :-
    findPositionInColumn(Row, Value, RowIndex, 0, Column),
    Result = RowIndex.
findPositionInRow([_|T], Value, RowIndex, Result, Column) :-
    RowIndex1 is RowIndex + 1,
    findPositionInRow(T, Value, RowIndex1, Result, Column).

% Get the positions of 'black' and 'white' workers in the board.
getWorkersPos(Board, WorkerRowBlack, WorkerColumnBlack, WorkerRowWhite, WorkerColumnWhite) :-
    getWorkersPosRow(Board, black, 0, WorkerRowBlack, WorkerColumnBlack),
    getWorkersPosRow(Board, white, 0, WorkerRowWhite, WorkerColumnWhite).

% Find the positions of 'black' or 'white' worker in a row.
getWorkersPosRow(Board, Value, RowIndex, WorkerRow, WorkerColumn) :-
    findPositionInRow(Board, Value, RowIndex, WorkerRow, WorkerColumn).

% Check if the board is full.
checkFullBoard(Board) :-
    \+ (member(Row, Board), member('empty', Row)).
