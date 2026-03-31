import 'dart:math';
import 'package:chess/application/commands/make_move/make_move_command.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:chess/core/models/game_session/utilities.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';

final class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key, required this.session});

  final GameSession session;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double boardSize = min(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return Chessboard(
          size: boardSize,
          orientation: session.getBoardOrientation(),
          fen: session.fen.value,
          game: GameData(
            playerSide: session.userSide,
            sideToMove: session.turn,
            validMoves: makeLegalMoves(
              Chess.fromSetup(Setup.parseFen(session.fen.value)),
            ),
            promotionMove: null,
            onMove: (move, {viaDragAndDrop}) => _onMoveCallback(move),
            onPromotionSelection: (piece) => _onPromotion(piece),
          ),
        );
      },
    );
  }

  void _onMoveCallback(Move move) {
    $dispatch(MakeMoveCommand(sessionId: session.sessionId, move: move));
  }

  void _onPromotion(Role? piece) {}
}
