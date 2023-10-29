manageRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

manageColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).

readRow(Row) :-
    write('  > Row    '),
    read(Row).

readColumn(Column) :-
    write('  > Column '),
    read(Column).

validateRow(1, NewRow) :-
    NewRow = 1.

validateRow(2, NewRow) :-
    NewRow = 2.

validateRow(3, NewRow) :-
    NewRow = 3.

validateRow(4, NewRow) :-
    NewRow = 4.

validateRow(5, NewRow) :-
    NewRow = 5.

validateRow(_Row, NewRow) :-
    write('ERROR: That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).

validateColumn(1, NewColumn) :-
    NewColumn = 1.

validateColumn(2, NewColumn) :-
    NewColumn = 2.

validateColumn(3, NewColumn) :-
    NewColumn = 3.

validateColumn(4, NewColumn) :-
    NewColumn = 4.

validateColumn(5, NewColumn) :-
    NewColumn = 5.


validateColumn(_Column, NewColumn) :-
    write('ERROR: That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).

manageMoveWorkerBool(NewMoveWorkerBool):-
      read(MoveWorkerBool),
      validateMoveWorkerBool(MoveWorkerBool, NewMoveWorkerBool).

validateMoveWorkerBool(1, NewMoveWorkerBool) :-
    NewMoveWorkerBool = 1.

validateMoveWorkerBool(0, NewMoveWorkerBool) :-
    NewMoveWorkerBool = 0.

validateMoveWorkerBool(_Bool, NewMoveWorkerBool) :-
    write('\nERROR: That answer is not valid, please try again![0(No)/1(Yes)]'),
    read(Input),
    validateMoveWorkerBool(Input, NewMoveWorkerBool).