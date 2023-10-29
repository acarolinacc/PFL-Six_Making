% Main Menu
mainMenu :-
    printMainMenu,
    askMenuOption,
    read(Input),
    manageInput(Input).

% Input Handling
manageInput(1) :- startGame('P', 'P'), mainMenu.
manageInput(2) :- startGame('P', 'C'), mainMenu.
manageInput(3) :- startGame('C', 'C'), mainMenu.
manageInput(4) :- write('Valid option!\n\n').
manageInput(0) :- write('\nExiting...\n\n').
manageInput(_Other) :- 
    write('\nERROR: That option does not exist.\n\n'),
    askMenuOption,
    read(Input),
    manageInput(Input).

% Print the Main Menu
printMainMenu :-
    nl,nl,
    printHeader,
    printOptions,
    nl,nl,nl.

% Print Header
printHeader :-
    write(' _______________________________________________________________________ '), nl,
    write('|                                                                       |'), nl,
    write('|         ___|  _)              \\  |         |    _)                    |'), nl,
    write('|       \\___ \\   | \\ \\  /      |\\/ |   _` |  |  /  |  __ \\    _` |      |'), nl,
    write('|             |  |  `  <       |   |  (   |    <   |  |   |  (   |      |'), nl,
    write('|       _____/  _|  _/\\_\\     _|  _| \\__,_| _|\\_\\ _| _|  _| \\__, |      |'), nl,
    write('|                                                           |___/       |'), nl, 
    write('|                                                                       |'), nl,
    write('|                                                                       |'), nl,
    write('|                          Ana Carolina Coutinho                        |'), nl,
    write('|                              *************                            |'), nl,
    write('|               -----------------------------------------               |'), nl,
    write('|                                                                       |'), nl,
    write('|                                                                       |'), nl.

% Print Menu Options
printOptions :-
    write('|                          1. Player vs Player                          |'), nl,
    write('|                                                                       |'), nl,
    write('|                          2. Player vs Computer                        |'), nl,
    write('|                                                                       |'), nl,
    write('|                          3. Computer vs Computer                      |'), nl,
    write('|                                                                       |'), nl,
    write('|                          0. Exit                                      |'), nl,
    write('|                                                                       |'), nl,
    write('|                                                                       |'), nl,
    write(' _______________________________________________________________________ ').

% Ask for Menu Option
askMenuOption :-
    write('\n> Insert your option ').
