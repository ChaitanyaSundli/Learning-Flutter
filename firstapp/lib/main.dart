import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,

      home: const Scaffold(body: Center(child: TicTacToe())),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<int> board = List.filled(9, 0);
  bool isPlayerO = true;

  void _resetGame() {
    setState(() {
      board = List.filled(9, 0);
      isPlayerO = true;
    });
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void makeMove(int index) {
    if (board[index] != 0) return;

    setState(() {
      board[index] = isPlayerO ? 1 : 2;
      isPlayerO = !isPlayerO;
    });

    int result = checkWinner(board);

    if (result == 1) {
      _showResultDialog("Player O Wins ");
    } else if (result == 2) {
      _showResultDialog("Player X Wins ");
    } else if (result == 0) {
      _showResultDialog("It's a Draw ");
    }
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var theme = Theme.of(context);

    return SafeArea(
      child: orientation == Orientation.portrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildGrid(),
                const SizedBox(height: 20),
                _buildControls(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: _buildGrid(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 40),
                        _buildControls(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    var theme = Theme.of(context);

    return Column(
      children: [
        Text(
          "Tic Tac Toe",
          style: theme.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isPlayerO ? "Player O's Turn" : "Player X's Turn",
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildCellContent(int index) {
    if (board[index] == 1) {
      return const Text(
        "O",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      );
    } else if (board[index] == 2) {
      return const Text(
        "X",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      );
    }
    return const SizedBox();
  }

  int checkWinner(List<int> board) {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ];

    for (var line in lines) {
      int a = board[line[0]];
      int b = board[line[1]];
      int c = board[line[2]];

      if (a != 0 && a == b && a == c) {
        return a;
      }
    }

    return board.contains(0) ? -1 : 0;
  }

  Widget _buildGrid() {
    var theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => makeMove(index),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: _buildCellContent(index)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls() {
    return ElevatedButton.icon(
      onPressed: _resetGame,
      icon: const Icon(Icons.refresh),
      label: const Text("Restart Game"),
    );
  }
}
