import 'dart:math';

import 'package:flutter/material.dart';

class GameControl {
  /// An integer variable to keep track of the current player
  /// who has a legal move
  ///
  /// 0 -> player 1
  /// 1 -> player 2 is computer and while computer has moves any and all clicks
  /// are ignored
  ///
  /// value rotates between 0 and 1
  int player = 1;

  /// gameOver -> if game is over the status changes to true
  ///
  /// false -> game has to continue untill either it is a win
  /// for either player or if all the cells are exhausted
  bool gameOver = false;

  ///  A 2D matrix is maintained for the game
  /// 0 -> for unpainted/untouched cell
  /// 1 -> for cells painted by circle user
  /// 2 -> for cells painted by cross user
  List<List<int>> gameBoard = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  /// 2D matrix for keeping track of the cells that are either
  /// touched or untouched,
  /// white ->  unpainted/untouched cell
  /// black ->  marked cell
  ///
  /// white color is used to mask off a $[Sentinel Icon] as it matches
  /// background color
  List<List<Color>> cellColors = [
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white]
  ];

  /// Symbol array containing the symbols of the designated character
  /// the player variable determines the index and thus once a cell is
  /// touched it will contain either of the index (1,2)
  List<IconData> sign = [
    Icons.abc,

    /// $[Sentinel Icon]
    Icons.circle_outlined,
    Icons.clear_outlined
  ];

  GameEngine gameEngine = GameEngine();

  void handleClick(
      int row, int col, BuildContext context, bool isSinglePlayer) {
    /// if cell is already marked we skip the click event
    /// 0 denotes the cell is untouched
    ///
    /// if player is 2, computer, no click is registered untill computer makes a move
    if (isSinglePlayer && player == 1) {
      return;
    }
    if (gameBoard[row][col] != 0) {
      return;
    }

    gameOver = isGameOver();

    /// game is terminated if it is gameOver is true
    if (!gameOver) {
      if (!isSinglePlayer) {
        player = (player + 1) % 2;
        gameBoard[row][col] = player == 0 ? 1 : 2;
        cellColors[row][col] = Colors.black;
      } else {
        if (player == 0) {
          // player
          gameBoard[row][col] = 1;
          cellColors[row][col] = Colors.black;
        }
      }
      if (isGameOver()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Player $player has won the game!!"),
          ),
        );

        return;
      }

      // if (isSinglePlayer) {
      //   List<int> bestMove = gameEngine.computeBestMove(gameBoard);
      //   print(bestMove.toString());
      //   gameBoard[bestMove[0]][bestMove[1]] = 1;
      //   player = 0;
      // }
    } else {
      /// if GAME OVER state has been reached then the variable
      /// gameOver is set to true
      /// A toast is shown which contains details of which player has won
      gameOver = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Player $player has won the game!!"),
        ),
      );
    }
  }

  void resetBoard() {
    gameBoard = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
    cellColors = [
      [Colors.white, Colors.white, Colors.white],
      [Colors.white, Colors.white, Colors.white],
      [Colors.white, Colors.white, Colors.white]
    ];
  }

  bool isGameOver() {
    /**
     * game is won under the condition that a straight line can be drawn
     * connecting the symbols of the same sign. this line has to be of length 3
     * 
     * the line drawn can be of the following shapes
     * 
     *            |   \       /    
     *[     --- , | ,  \  ,  /      ]
     *            |     \   /
     * 
     * 
     */

    // Horizontal and Vertical line detection
    for (var i = 0; i < 3; i++) {
      // column detection
      int startCellCol = gameBoard[0][i];
      if (startCellCol == 0) {
        continue;
      }
      int countCol = 0;
      for (var j = 0; j < 3; j++) {
        if (startCellCol == gameBoard[j][i]) {
          ++countCol;
        }
      }

      if (countCol == 3) {
        return true;
      }

      int startCellRow = gameBoard[i][0];
      if (startCellRow == 0) {
        continue;
      }
      int countRow = 0;
      for (var j = 0; j < 3; j++) {
        if (startCellRow == gameBoard[i][j]) {
          ++countRow;
        }
      }

      if (countRow == 3) {
        return true;
      }
    }

    // Diagonal line detection
    int diagonalCountForward = 0;
    int diagonalCountBackward = 0;
    int diagonalStartForward = gameBoard[0][0];
    int diagonalStartBackward = gameBoard[2][2];
    if (diagonalStartForward == 0 || diagonalStartBackward == 0) {
      return false;
    }
    for (var i = 0; i < 3; i++) {
      if (gameBoard[i][i] == diagonalStartForward) {
        ++diagonalCountForward;
      }

      if (gameBoard[2 - i][2 - i] == diagonalStartBackward) {
        ++diagonalCountBackward;
      }
    }

    if (diagonalCountForward == 3) {
      return true;
    }

    if (diagonalCountBackward == 3) {
      return true;
    }

    return false;
  }

  // bool makeMove(int row, int col) {
  //   if (!legalMove(row, col)) return false;
  //   gameBoard[row][col] = player;

  //   if (isGameOver()) {
  //     return true;
  //   }

  //   updatePlayer();

  //   return false;
  // }

  // updatePlayer() {
  //   player = player == 1 ? 2 : 1;
  // }

  // bool legalMove(int row, int col) {
  //   return gameBoard[row][col] == 0;
  // }
}

class Move {
  int row = -1;
  int col = -1;

  Move(this.row, this.col);
}

class GameEngine {
  int player = 1;
  int opponent = 2;

  /// alpha beta prunning algo
  /// This will return the best possible
  /// move for the player
  List<int> computeBestMove(List<List<int>> gameBoard) {
    int bestVal = -1000;
    Move bestMove = Move(-1, -1);

    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (gameBoard[i][j] == 0) {
          gameBoard[i][j] = player;

          int moveVal = minimax(gameBoard, 0, false);

          gameBoard[i][j] = 0;

          if (moveVal > bestVal) {
            bestMove.row = i;
            bestMove.col = j;
            bestVal = moveVal;
          }
        }
      }
    }
    // List<int> returnableBestMove = [bestMove.row, bestMove.col];

    return [bestMove.row, bestMove.col];
  }

  /// This is the minimax function. It considers all
  /// the possible ways the game can go and returns
  /// the value of the board
  int minimax(List<List<int>> gameBoard, int depth, bool isMax) {
    int score = evaluate(gameBoard);

    if (score.abs() == 10) {
      return score;
    }

    if (isMovesLeft(gameBoard) == false) {
      return 0;
    }

    if (isMax) {
      int best = -1000;

      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (gameBoard[i][j] == 0) {
            gameBoard[i][j] = player;
            best = max(best, minimax(gameBoard, depth + 1, !isMax));

            /// note around here
            gameBoard[i][j] = 0;
          }
        }
      }
      return best;
    } else {
      int best = 1000;

      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (gameBoard[i][j] == 0) {
            gameBoard[i][j] = opponent;
            best = min(best, minimax(gameBoard, depth + 1, !isMax));
            gameBoard[i][j] = 0;
          }
        }

        return best;
      }
    }

    return 0;
  }

  /// This function returns true if there are moves
  /// remaining on the board. It returns false if
  /// there are no moves left to play.
  bool isMovesLeft(List<List<int>> gameBoard) {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (gameBoard[i][j] == 0) {
          return true;
        }
      }
    }

    return false;
  }

  /// Returns a value based on who is winning
  /// gameBoard[3][3] is the Tic-Tac-Toe board
  int evaluate(List<List<int>> gameBoard) {
    // Checking for Rows for X or O victory.
    for (int row = 0; row < 3; row++) {
      if (gameBoard[row][0] == gameBoard[row][1] &&
          gameBoard[row][1] == gameBoard[row][2]) {
        if (gameBoard[row][0] == player) {
          return 10;
        } else if (gameBoard[row][0] == opponent) {
          return -10;
        }
      }
    }

    // Checking for Columns for X or O victory.
    for (int col = 0; col < 3; col++) {
      if (gameBoard[0][col] == gameBoard[1][col] &&
          gameBoard[1][col] == gameBoard[2][col]) {
        if (gameBoard[0][col] == player) {
          return 10;
        } else if (gameBoard[0][col] == opponent) {
          return -10;
        }
      }
    }

    // Checking for Diagonals for X or O victory.
    if (gameBoard[0][0] == gameBoard[1][1] &&
        gameBoard[1][1] == gameBoard[2][2]) {
      if (gameBoard[0][0] == player) {
        return 10;
      } else if (gameBoard[0][0] == opponent) {
        return -10;
      }
    }

    if (gameBoard[0][2] == gameBoard[1][1] &&
        gameBoard[1][1] == gameBoard[2][0]) {
      if (gameBoard[0][2] == player) {
        return 10;
      } else if (gameBoard[0][2] == opponent) {
        return -10;
      }
    }

    // Else if none of them have won then return 0
    return 0;
  }
}
