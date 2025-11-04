
-----------------
Class: Player
-----------------
Responsibilities:
has name
has color
-----------------
Collaborators:
Game
-----------------


-----------------
Class: Piece
-----------------
Responsibilities:
has name
knows current location
-----------------
Collaborators:
Game
Player?
-----------------


-----------------
Class: Board
-----------------
Responsibilities:
has pieces
has algebraic notation (a-h for columns, 1-8 for rows)
know correct moves
knows check
knows checkmate
-----------------
Collaborators:
Game
-----------------


-----------------
Class: Game
-----------------
Responsibilities:
has 2 players
has a board
handles turns
-----------------
Collaborators:
Board
Player
Piece
-----------------
