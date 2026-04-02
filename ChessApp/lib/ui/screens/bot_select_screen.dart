import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/states.dart';
import 'package:chess/routing/go_router_builder.dart';
import 'package:chess/ui/widgets/popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class BotSelectScreen extends StatelessWidget {
  const BotSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        
        // Show dialog if have active session with bot
        BlocListener<BotSelectBloc, BotSelectBlocState>(
          listener: (context, state) {
            if (state is BotsLoaded && state.pendingSession != null) {
              final pending = state.pendingSession!;
              showTwoOptionPopup(
                context,
                title: 'Continue Game?',
                message:
                    'You have an active game against ${pending.bot.getLabelForDifficulty()} bot. Would you like to continue?',
                firstOptionLabel: 'New Game',
                onFirstOption: () {
                  context.read<BotSelectBloc>().add(
                    MatchRequested(bot: pending.bot, forceStart: true),
                  );
                },
                secondOptionLabel: 'Continue',
                onSecondOption: () {
                  context.read<BotSelectBloc>().add(
                    ContinueMatchRequested(session: pending.existingSession),
                  );
                },
              );
            }
          },
        ),
        
        // Start match when ready (redirect to game screen)
        BlocListener<BotSelectBloc, BotSelectBlocState>(
          listener: (context, state) {
            if (state is MatchReady) {
              context.read<BotSelectBloc>().add(const MatchStarted());
              GameScreenRoute(sessionId: state.sessionId.uuid).push(context);
            }
          },
        ),

        // If error occured
        BlocListener<BotSelectBloc, BotSelectBlocState>(
          listener: (context, state) {
            if (state is BotSelectError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<BotSelectBloc, BotSelectBlocState>(
        builder: (context, state) {
          debugPrint(state.toString());
          return Scaffold(
            appBar: AppBar(title: const Text('Select Bot'), centerTitle: true),
            body: switch (state) {
              BotsLoading() || BotSelectInitial() => const _LoadingState(),
              BotSelectError() => _ErrorState(message: state.message),
              BotsLoaded() => _BotSelectScreenContent(
                bots: state.bots,
                selectedBot: state.selectedBot,
              ),
              _ => const SizedBox.shrink(),
            },
          );
        },
      ),
    );
  }
}

final class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    context.read<BotSelectBloc>().add(BotOptionsRequested());
    return const Center(child: CircularProgressIndicator());
  }
}

final class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $message'));
  }
}

final class _BotSelectScreenContent extends StatelessWidget {
  const _BotSelectScreenContent({
    required this.bots,
    required this.selectedBot,
  });

  final Set<BotOpponent> bots;
  final BotOpponent selectedBot;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Expanded(
            child: ListView.builder(
              itemCount: bots.length,
              itemBuilder: (context, index) {
                final bot = bots.elementAt(index);
                final isSelected = selectedBot.difficulty == bot.difficulty;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    elevation: isSelected ? 4 : 2,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () => context.read<BotSelectBloc>().add(
                        BotSelected(bot: bot),
                      ),
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
                                    'Bot ${bot.displayName}: Level ${bot.difficulty}',
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
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => context.read<BotSelectBloc>().add(
                MatchRequested(bot: selectedBot),
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
    );
  }
}
