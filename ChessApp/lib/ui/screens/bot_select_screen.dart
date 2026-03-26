import 'package:chess/core/models/game_session.dart';
import 'package:chess/routing/go_router_builder.dart';
import 'package:flutter/material.dart';

final class BotSelectScreen extends StatelessWidget {
  const BotSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Bot')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose bot:'),
            const SizedBox(height: 20),
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () =>
                      onBotSelected(context, BotDifficulty(level: index + 1)),
                  child: Text('Level ${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBotSelected(BuildContext context, BotDifficulty difficulty) =>
      GameScreenRoute(id: difficulty.level).push(context);
}
