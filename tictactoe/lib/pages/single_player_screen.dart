import 'package:flutter/material.dart';
import "dart:io";

import '../engine/engine.dart';

class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({super.key});

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  GameControl gameControl = GameControl();
  GameEngine gameEngine = GameEngine();

  ///
  ///  * 0 -> not painted
  ///  * 1 -> painted cross
  ///  * 2 -> painted circle
  ///
  List<IconData> sign = [
    Icons.abc,
    Icons.circle_outlined,
    Icons.clear_outlined
  ];

  void handleClick(int row, int col) {
    setState(() {
      gameControl.handleClick(row, col, context, true);
      List<int> bestMove = gameEngine.computeBestMove(gameControl.gameBoard);
      
      gameControl.gameBoard[bestMove[0]][bestMove[1]] = 2;
      gameControl.cellColors[bestMove[0]][bestMove[1]] = Colors.black;
      gameControl.player = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 100;
    double size = width < height
        ? width < 400
            ? width
            : 400
        : height < 400
            ? height
            : 400;

    return Scaffold(
      appBar: AppBar(
        title: const Text("multiplayer"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.circle_outlined,
                      color: gameControl.player == 1
                          ? Colors.green
                          : Colors.black38,
                      size: 100,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.clear_outlined,
                      color: gameControl.player == 0
                          ? Colors.green
                          : Colors.black38,
                      size: 100,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.black,
                      child: GridView.count(
                        crossAxisCount: 3,
                        padding: const EdgeInsets.all(5),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(0, 0);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[0][0]],
                              color: gameControl.cellColors[0][0],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(0, 1);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[0][1]],
                              color: gameControl.cellColors[0][1],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(0, 2);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[0][2]],
                              color: gameControl.cellColors[0][2],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(1, 0);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[1][0]],
                              color: gameControl.cellColors[1][0],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(1, 1);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[1][1]],
                              color: gameControl.cellColors[1][1],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(1, 2);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[1][2]],
                              color: gameControl.cellColors[1][2],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(2, 0);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[2][0]],
                              color: gameControl.cellColors[2][0],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(2, 1);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[2][1]],
                              color: gameControl.cellColors[2][1],
                              size: 100,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              handleClick(2, 2);
                            },
                            child: Icon(
                              sign[gameControl.gameBoard[2][2]],
                              color: gameControl.cellColors[2][2],
                              size: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment(2/(3), 0),
                  //   child: Container(
                  //     width: 10,
                  //     height: size,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gameControl.resetBoard();
                    });
                  },
                  child: Text("Reset")),
            )
          ],
        ),
      ),
    );
  }
}
