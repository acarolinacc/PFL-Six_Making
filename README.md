# PFL TP1: Six Making Game
**Group Designation**
- Ana Carolina da Costa Coutinho 	(up202108685)
- Tomás Pacheco Pires 	(up202008319)

**Contribution**

TO DO

# Installation and Execution

## **Linux Environment**

Install SICStus Prolog 4.8. You can download it from [official website link].

Clone the Six Making Game repository: git clone [repository URL]

Navigate to the project directory: cd Six_Making_Game

Run the game: sicstus -l main.pl


## **Windows Environment**

Download and install SICStus Prolog 4.8 from [official website link].

Clone the Six Making Game repository: git clone [repository URL]

Open the SICStus Prolog IDE.

Load the game by navigating to File -> Consult... -> Select main.pl -> OK.

Execute the game by typing play. in the Prolog command prompt.


## Description of the Game
Six Making is a board game in which players must stack a total of 6 pieces, with their own on top, to win the game.
The game is played on a 5x5 board, with each player owning 16 pieces; in each player's turn, they may either place one of their pieces on any empty space on the board, or move one of their pieces or towers on top of another.
The height of a tower also dictates its movement rules:
- 1 piece (Pawn)	: moves 1 space in all 4 orthogonal directions;
- 2 pieces (Rook)	: moves any number of spaces in one of the 4 orthogonal directions;
- 3 pieces (Knight) : moves in an L-shape (2 spaces then 1 space laterally);
- 4 pieces (Bishop)	: moves any number of spaces in one of the 4 diagonal directions;
- 5 pieces (Queen)	: moves any number of spaces in all 8 directions.
A player may play a tower as long as one of its pieces belongs to them; furthermore, a player may split a tower by taking a certain number of pieces from the top and playing it in the same way the original tower would be played.
Finally, a player may not make a move that leads to the same situation from 2 turns ago.

[Original Rulebook](https://www.boardspace.net/sixmaking/english/Six-MaKING-rules-Eng-Ger-Fra-Ro-Hu.pdf)

Official Game Website: [Insert official game website link]


## Game Logic

### **Internal Game State Representation**

Six Making, the game state is represented using a list of lists to represent the board. Different atoms represent various pieces. Here are examples of Prolog representations for initial, intermediate, and final game states, along with explanations of each atom's meaning.

Initial Game State:

% Add Prolog representation of the initial game state here

Intermediate Game State:

% Add Prolog representation of an intermediate game state here

Final Game State:

% Add Prolog representation of the final game state here

**Game State Visualization**

The display_game(+GameState) predicate is responsible for visualizing the game state, including the menu system and user interaction. It ensures an intuitive and appealing display of the current game status.

**Move Validation and Execution**

The move(+GameState, +Move, -NewGameState) predicate validates and executes player moves, resulting in a new game state.

**List of Valid Moves**

The valid_moves(+GameState, +Player, -ListOfMoves) predicate calculates the list of valid moves for a given player in the current game state.

**End of Game**

The game_over(+GameState, -Winner) predicate determines the game's end and identifies the winner.

**Game State Evaluation**

The value(+GameState, +Player, -Value) predicate evaluates the game state to assist in making strategic decisions.

**Computer Plays**

The choose_move(+GameState, +Player, +Level, -Move) predicate defines the computer's move selection algorithm based on the chosen difficulty level (1 or 2).

## Conclusions
TO DO

## Bibliography

[List of references and resources used during development]
