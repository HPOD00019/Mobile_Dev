import 'package:chess/core/models/game_session.dart';
import 'package:chess/ui/widgets/chess_board.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


abstract class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getOpponentName()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: ChessBoard()),
            ),
          ),
        ],
      ),
    );
  }

  @protected
  String getOpponentName() => "Anonymus";
}

final class GameWithBotScreen extends GameScreen {
  final BotDifficulty bot;

  const GameWithBotScreen({super.key, required this.bot});

  @override
  String getOpponentName() => "Bot: $bot";
}
