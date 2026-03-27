import 'package:chess/application/commands/confirm_bot_selection/play_with_bot_command.dart';
import 'package:chess/application/queries/get_bots/get_bots_query.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';
import 'package:provider/provider.dart';

final class BotSelectSreenState extends ChangeNotifier {
  @protected
  final Set<BotOpponent> bots;
  @protected
  BotOpponent selectedBot;

  BotSelectSreenState({required this.bots, required this.selectedBot});

  void selectBotByIndex(int index) {
    assert(bots.elementAtOrNull(index) != null, "Index out of range");
    selectedBot = bots.elementAt(index);
    notifyListeners();
  }

  void selectBot(BotOpponent value) {
    var matched = bots.where((bot) => value.difficulty == bot.difficulty);
    assert(matched.isNotEmpty, "Not bot found!");
    selectedBot = matched.first;
    notifyListeners();
  }
}

final class BotSelectScreen extends StatelessWidget {
  const BotSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: GetBotsQuery(),

      waiterBuilder: (context) => const CircularProgressIndicator(),
      errorBuilder: (context, _, error) => Text('Error: $error'),

      builder: (context, bots) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) =>
                  BotSelectSreenState(bots: bots, selectedBot: bots.first),
            ),
          ],
          child: _BotSelectScreenContent(),
        );
      },
    );
  }
}

final class _BotSelectScreenContent extends StatelessWidget {
  const _BotSelectScreenContent();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<BotSelectSreenState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Bot'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Choose Your Opponent',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Select difficulty level',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            // Bots list
            Expanded(
              child: ListView.builder(
                itemCount: state.bots.length,
                itemBuilder: (context, index) {
                  // Item local state (button tracks it's own state)
                  final bot = state.bots.elementAt(index);
                  final isSelected =
                      state.selectedBot.difficulty.level ==
                      bot.difficulty.level;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      elevation: isSelected ? 4 : 2,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () => state.selectBot(bot),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                            color: isSelected
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1)
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.castle,
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[700],
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Level ${bot.difficulty.level}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      bot.getLabelForDifficulty(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: 28,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Play button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => $dispatch(
                  PlayWithBotCommand(context: context, bot: state.selectedBot),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

