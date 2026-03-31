
import 'dart:math';
import 'package:chess/application/commands/make_move/make_move_command.dart';
import 'package:chess/application/events/game_session_state_changed_event.dart';
import 'package:chess/application/state/application_storage.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:chess/core/models/game_session/operations.dart';
import 'package:chess/core/models/game_session/utilities.dart';
import 'package:chess/persistence/sessions_repository.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';


@injectable
final class MakeMoveCommandHandler
    implements ICommandHandler<MakeMoveCommand, void> {
  const MakeMoveCommandHandler({
    required this.sessions,
    required this.appStorage,
  });

  final ISessionRepository sessions;
  final ApplicationStorage appStorage;

  @override
  Future<void> handle(MakeMoveCommand command) async {
    // Get the current session
    var session = sessions.getById(command.sessionId);

    debugPrint('[HANDLER]:::: ${session.toString()}');

    // Apply player's move
    session = session.applyMove(command.move);

    // Update session in repository
    sessions.update(session);

    // Notify UI about changes
    $emit(GameSessionStateChangedEvent(), skipIfSameAsLastEmitted: false);

    // If game is not over and playing against bot, make bot move
    if (session.status == GameStatus.active) {
      if (session.isUserTurn() == false) {
        await _makeBotMove(session);
      }
    }
  }

  Future<void> _makeBotMove(GameSession session) async {
    // Small delay to simulate thinking
    await Future.delayed(const Duration(milliseconds: 500));

    // Get fresh session state
    final SessionId sessionId = (value: session.sessionId.value);
    var currentSession = sessions.getById(sessionId);

    if (currentSession.status != GameStatus.active) return;

    final botMove = _getBotMove(currentSession);
    if (botMove != null) {
      currentSession = currentSession.applyMove(botMove);
      sessions.update(currentSession);
      $emit(GameSessionStateChangedEvent(), skipIfSameAsLastEmitted: false);
    }
  }

  Move? _getBotMove(GameSession session) {
    final chess = Chess.fromSetup(Setup.parseFen(session.fen.value));
    final legalMoves = chess.legalMoves;

    if (legalMoves.isEmpty) return null;

    // Collect all possible moves from the IMap<Square, SquareSet>
    // dartchess.legalMoves already returns moves only for the side whose turn it is
    final List<NormalMove> movesList = [];
    for (final entry in legalMoves.entries) {
      final from = entry.key;
      final destinations = entry.value;
      // Use .squares to iterate over SquareSet
      for (final to in destinations.squares) {
        // Handle promotions - prefer queen promotion for simplicity
        final piece = chess.board.pieceAt(from);

        if (piece == null) {
          continue;
        }

        if (piece.promoted) {
          movesList.add(NormalMove(from: from, to: to, promotion: Role.queen));
        } else {
          movesList.add(NormalMove(from: from, to: to));
        }
      }
    }

    if (movesList.isEmpty) return null;

    final random = Random();
    return movesList[random.nextInt(movesList.length)];
  }
}
