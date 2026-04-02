import 'package:chess/application/events/game_session_state_changed_event.dart';
import 'package:chess/application/queries/get_session/get_session_by_id_queary.dart';
import 'package:chess/application/queries/get_session/responses/get_session_response.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chess/ui/widgets/chess_board.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamline/streamline.dart';

final class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.sessionId});

  final SessionId sessionId;

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: GetSessionByIdQueary(id: sessionId),
      eventObservers: [$eventStream<GameSessionStateChangedEvent>()],
      waiterBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      builder: (context, response) => switch (response) {
        Found found => _GameSceen(session: found.session),
        _ =>
          throw Exception(), // TODO: Render some kind of error and redirect to main screen here
      },
    );
  }
}

final class _GameSceen extends StatelessWidget {
  const _GameSceen({required this.session});

  final GameSession session;

  @override
  Widget build(BuildContext context) {
    final whiteOpponent = session.white;
    final blackOpponent = session.black;

    debugPrint(session.toString());

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
              isActive: session.turn == Side.black,
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
                      child: ChessBoard(session: session),
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
              isActive: session.turn == Side.white,
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
    final whiteName = session.white.displayName.value;
    final blackName = session.black.displayName.value;
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
                  opponent.displayName.value,
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
      BotOpponent bot => 'Rating: ${1200 + bot.difficulty.level * 300}',
      HumanOpponent human => 'Rating: ${human.profile.elo.amount.toInt()}',
      Opponent _ => 'Rating: unknown',
    };
  }
}
