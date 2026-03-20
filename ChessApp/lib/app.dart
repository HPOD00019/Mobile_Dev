import 'package:chess/ui/widgets/chess_board.dart';
import 'package:flutter/material.dart';

final class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Chess")),
        body: ChessBoard(),
      ),
    );
  }
}
