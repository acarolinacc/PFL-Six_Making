:- dynamic board/1.
:- dynamic previousBoard/1.

% Inicializa o tabuleiro no início do jogo.
initBoard :-
    initialBoard(InitialBoard),
    assertz(board(InitialBoard)),
    assertz(previousBoard(InitialBoard)).

% Atualiza o tabuleiro atual e o tabuleiro anterior.
updateBoard(NewBoard) :-
    retract(board(_)),
    assertz(board(NewBoard)),
    retract(previousBoard(_)),
    assertz(previousBoard(NewBoard)).

% Use o tabuleiro atual no início de cada jogada.
getCurrentBoard(CurrentBoard) :-
    board(CurrentBoard).

% Verifica o estado atual do jogo após cada jogada.
checkGameState(Player, Board) :-
    (
        (checkFullBoard(Board), write('Woops, no more space left! It is a draw!'));
        (checkValidSpots(Board, 0, 0, Result), Result =:= 0, write('Woops, no more space left! It is a draw!'))
    ).


% Loop do jogo, em que recebe a jogada de cada jogador e verifica o estado do jogo a seguir.
gameLoop(Board, Player1, Player2) :-
    getCurrentBoard(CurrentBoard),
    (
        Player1 == 'P' -> 
            (
                % Use o tabuleiro atual
                blackPlayerTurn(CurrentBoard, NewBoard, Player1),
                updateBoard(NewBoard)
            );
        Player1 == 'C' -> 
            (
                % Use o tabuleiro atual
                blackPlayerTurn(CurrentBoard, NewBoard, Player1),
                updateBoard(NewBoard)
            )
    ),
    (
        (checkGameState('black', NewBoard), write('\nThanks for playing!\n'));
        (
            Player2 == 'P' -> 
                (
                    % Use o tabuleiro atual
                    whitePlayerTurn(NewBoard, FinalBoard, Player2),
                    updateBoard(FinalBoard)
                );
            Player2 == 'C' -> 
                (
                    % Use o tabuleiro atual
                    whitePlayerTurn(NewBoard, FinalBoard, Player2),
                    updateBoard(FinalBoard)
                )
        ),
        (
            (checkGameState('white', FinalBoard), write('\nThanks for playing!\n'));
            gameLoop(FinalBoard, Player1, Player2)
        )
    ).


checkValidSpots(Board, Row, Column, Result) :-
      (
            (Column =:= 11, Row1 is Row + 1, checkValidSpots(Board, Row1, 0, Result));
            (Row =:= 11, Result is 0);
            ((isValidPosLines(Board, Row, Column, Res)), 
                  ((Res =:= 0, Column1 is Column + 1, checkValidSpots(Board, Row, Column1, Result));
                  (Res =:=1 , Result is 1)))
      ), !.

isValidPosLines(Board, Row, Column, Res) :-
    isEmptyCell(Board, Row, Column, Res).

isEmptyCell(Board, Row, Column, Res) :-
    ((getValueFromMatrix(Board, Row, Column, Value), Value == empty, !, Res is 1);
    Res is 0).

checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex) :-
    (
        % Verifica se o jogador tenta mover um trabalhador vazio para uma célula com uma peça esperada (black ou white).
        (Player == empty, member(Expected, [black, white]),
            (
                getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard)
                ;
                write('INVALID MOVE: There is no worker in that cell, please try again!\n\n'),
                askCoords(Board, Player, NewBoard, Expected)
            )
        )
        ;

        % Verifica se o jogador tenta mover uma peça (black ou white) para uma célula vazia (empty).
        ((Player == black; Player == white), Expected == empty,
            (
                getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard)
                ;
                write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
                askCoords(Board, Player, NewBoard, Expected)
            )
        )
        ;

        % Outras situações de movimento inválido.
        (
            write('INVALID MOVE: This move is not allowed, please try again!\n\n'),
            askCoords(Board, Player, NewBoard, Expected)
        )
    ).


/*Predicado que pede e analisa cada jogada.*/
askCoords(Board, Player, NewBoard, Expected) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex).

moveWorkerBlack(Board, 0, NewBoard) :-
      % Obtenha o tabuleiro anterior
      previousBoard(PreviousBoard),
      % Use o tabuleiro anterior
      NewBoard = PreviousBoard,
      write('\n1. Choose pawn cell.\n'),
      askCoords(Board, black, Worker1Board, empty),
      printBoard(Worker1Board).


moveWorkerBlack(Board, 1, NewBoard) :-
        write('\n2. Choose tower current cell.\n'),
        askCoords(Board, empty, NoWorkerBoard, black),
        write('3. Choose tower new cell.\n'),
        askCoords(NoWorkerBoard, black, NewBoard, empty),
        printBoard(NewBoard).

moveWorkerWhite(Board, 0, NewBoard) :-
    % Obtenha o tabuleiro anterior
    previousBoard(PreviousBoard),
    % Use o tabuleiro anterior
    NewBoard = PreviousBoard,
    write('\n1. Choose pawn cell.\n'),
    askCoords(Board, white, Worker1Board, empty),
    printBoard(Worker1Board).

        
moveWorkerWhite(Board, 1, NewBoard) :-
        write('\n2. Choose tower current cell.\n'),
        askCoords(Board, empty, NoWorkerBoard, white),
        write('3. Choose tower new cell.\n'),
        askCoords(NoWorkerBoard, white, NewBoard, empty),
        printBoard(NewBoard).

addWorkers(InitialBoard, WorkersBoard, 'P', 'P') :-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose pawn cell.\n'),
      askCoords(InitialBoard, black, Worker1Board, empty),
      printBoard(Worker1Board),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Choose pawn cell.\n'),
      askCoords(Worker1Board, white, WorkersBoard, empty),
      printBoard(WorkersBoard).

blackPlayerTurn(Board, NewBoard, 'P') :-
    write('\n------------------ PLAYER X -------------------\n\n'),
    write('1. Do you want to move a worker or add a piece? [0(No)/1(Yes)]'),
    manageMoveWorkerBool(MoveWorkerBoolX),
    (
        MoveWorkerBoolX =:= 1,
        moveWorkerBlack(Board, MoveWorkerBoolX, Board1),
        (
            checkGameState('black', Board1),
            NewBoard = Board1
            ;
            whitePlayerTurn(Board1, NewBoard, 'P')
        )
        ;
        MoveWorkerBoolX =:= 0,
        % Continue without moving a worker and allow the player to add a new piece
        write('2. Choose a cell to add a new piece.\n'),
        askCoords(Board, black, TempBoard, empty),
        printBoard(TempBoard), % Adicione esta linha para imprimir o tabuleiro atual
        gameLoop(TempBoard, 'P', 'P') % Altere 'C' para 'P' para continuar com o mesmo jogador
    ).

whitePlayerTurn(Board, NewBoard, 'P') :-
    write('\n------------------ PLAYER O -------------------\n\n'),
    write('1. Do you want to move a worker or add a piece? [0(No)/1(Yes)]'),
    manageMoveWorkerBool(MoveWorkerBoolO),
    (
        MoveWorkerBoolO =:= 1,
        moveWorkerWhite(Board, MoveWorkerBoolO, Board1),
        (
            checkGameState('white', Board1),
            NewBoard = Board1
            ;
            blackPlayerTurn(Board1, NewBoard, 'P')
        )
        ;
        MoveWorkerBoolO =:= 0,
        % Continue without moving a worker and allow the player to add a new piece
        write('2. Choose a cell to add a new piece.\n'),
        askCoords(Board, white, TempBoard, empty),
        printBoard(TempBoard), % Adicione esta linha para imprimir o tabuleiro atual
        gameLoop(TempBoard, 'P', 'P') % Adicione esta linha para alternar automaticamente para o próximo jogador
    ).


gameLoop(Board, Player1, Player2) :-
      blackPlayerTurn(Board, NewBoard, Player1),
      (
            (checkGameState('black', NewBoard), write('\nThanks for playing!\n'));
            (whitePlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (checkGameState('white', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
            )
      ).

startGame(Player1, Player2) :-
      initialBoard(InitialBoard),
      addWorkers(InitialBoard, WorkersBoard, Player1, Player2),
      gameLoop(WorkersBoard, Player1, Player2).
