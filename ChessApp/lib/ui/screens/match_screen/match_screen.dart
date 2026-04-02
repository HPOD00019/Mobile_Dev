import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/states.dart';
import 'package:chess/features/chess/presentation/chess_board.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key, required this.sessionId});

  final SessionId sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChessMatchBloc, ChessMatchBlocState>(
      builder: (context, state) => switch (state) {
        EmptyState _ => _loadMatch(context),
        MatchStateActive active => _MatchSceen(state: active.state),
        InternalError error => ErrorWidget(error.error),
        _ => ErrorWidget("Unknown error")
      },
    );
  }
  
  Widget _loadMatch(BuildContext context) {
    context.read<ChessMatchBloc>().add(LoadMatchRequested(sessionId: sessionId));
    return Center(child: const CircularProgressIndicator());
  }
}

final class _MatchSceen extends StatelessWidget {
  const _MatchSceen({required this.state});

  final MatchState state;

  @override
  Widget build(BuildContext context) {
    final whiteOpponent = state.white;
    final blackOpponent = state.black;

    debugPrint(state.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(_getGameLabel()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onSessionLeave(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Top opponent (Black)
            _OpponentCard(
              opponent: blackOpponent,
              isTop: true,
              isActive: state.position.turn == Side.black,
            ),

            const SizedBox(height: 16),

            // Chess Board with frame
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[400]!, width: 1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ChessBoard(state: state)
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bottom opponent (White)
            _OpponentCard(
              opponent: whiteOpponent,
              isTop: false,
              isActive: state.position.turn == Side.white,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void onSessionLeave(BuildContext context) {
    context.pop();
  }

  String _getGameLabel() {
    final whiteName = state.white.displayName;
    final blackName = state.black.displayName;
    return '$whiteName vs $blackName';
  }
}

final class _OpponentCard extends StatelessWidget {
  const _OpponentCard({
    required this.opponent,
    required this.isTop,
    required this.isActive,
  });

  final Opponent opponent;
  final bool isTop;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey[300]!,
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
      ),
      child: Row(
        children: [
          // Avatar placeholder
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isTop ? Icons.person : Icons.person_outline,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Opponent info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opponent.displayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.stars,
                      size: 16,
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getEloForOpponent(opponent),
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Active indicator
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Thinking',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          if (!isActive)
            Icon(
              isTop ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              color: Colors.grey[500],
              size: 24,
            ),
        ],
      ),
    );
  }

  String _getEloForOpponent(Opponent opponent) {
    return switch (opponent) {
      BotOpponent bot => 'Rating: ${1200 + bot.difficulty * 300}',
      HumanOpponent human => 'Rating: ${human.profile.elo.amount}',
      Opponent _ => 'Rating: unknown',
    };
  }
}
