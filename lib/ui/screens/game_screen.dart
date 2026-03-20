import 'package:chess/ui/widgets/chess_board.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final String currentFen;

  const GameScreen({super.key, required this.currentFen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chess Game')),
      body: ChessBoard(),
    );
  }
}
