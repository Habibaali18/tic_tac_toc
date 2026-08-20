import 'package:flutter/material.dart';
import 'Timer.dart';
import 'colors.dart';
import 'header.dart';

class GameBoard extends StatefulWidget {
  final Function(bool) onTurnChanged;
  final String initialPlayer;

  const GameBoard({
    super.key,
    required this.onTurnChanged,
    required this.initialPlayer,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> board = List.filled(9, "");
  late bool isXTurn;
  bool gameOver = false;
  String winnerMessage = "";
  int resetCount = 0;

  @override
  void initState() {
    super.initState();
    isXTurn = widget.initialPlayer == 'X';
  }

  // check handel tap
  void handleTap(int index) {
    if (board[index] == "" && !gameOver) {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        String? winner = checkWiner();
        if (winner != null) {
          gameOver = true;
          winnerMessage = "Player $winner Wins! 🎉";
        } else if (isBoardFull()) {
          gameOver = true;
          winnerMessage = "It's a Draw! 🤝";
        } else {
          isXTurn = !isXTurn;
          widget.onTurnChanged(isXTurn);
        }
      });
    }
  }

  // check winner
  String? checkWiner() {
    List<List<int>> winPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winPositions) {
      if (board[pos[0]] != "" &&
          board[pos[0]] == board[pos[1]] &&
          board[pos[0]] == board[pos[2]]) {
        return board[pos[0]];
      }
    }
    return null;
  }

  // play again
  void resetGame() {
    setState(() {
      board = List.filled(9, "");
      isXTurn = widget.initialPlayer == 'X';
      gameOver = false;
      winnerMessage = "";
      resetCount++;
      widget.onTurnChanged(isXTurn);
    });
  }

  // is BoardFull??
  bool isBoardFull() {
    return !board.contains("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.boackgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Header(isXTurn: isXTurn),

                const SizedBox(height: 12),
                TimerWedget(key: ValueKey(resetCount), isRunning: !gameOver),

                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.White,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => handleTap(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  board[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: board[index] == 'X'
                                        ? AppColors.XRed
                                        : AppColors.OGreen,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                if (gameOver)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          winnerMessage,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.White,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: resetGame,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.XRed,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            "Play Again",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
