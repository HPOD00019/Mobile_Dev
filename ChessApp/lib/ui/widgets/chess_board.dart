import 'dart:math';

import 'package:chess/application/queries/get_session/get_session_queary.dart';
import 'package:chess/core/models/game_session.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';

final class ChessBoard extends StatelessWidget{
  const ChessBoard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      // TODO: Implement local storage (repository) to store sessions -> will enable to play 10 games at once future 
      query: GetSessionQueary(sessionId: (value: "0")),
      builder: (context, response) => _ChessBoard(session: response));
  }
}

// UI for chess board
final class _ChessBoard extends StatelessWidget{

  const _ChessBoard({required this.session});

  final GameSession session;

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double boardSize = min(screenHeight, screenWidth) - 64;

    return Center(
        child: Chessboard(
          size: boardSize,
          orientation: session.playerSide.getOrientetion(session.turn),
          fen: session.fen.value,
          game: GameData(
            playerSide: session.playerSide,
            sideToMove: session.turn,
            validMoves: makeLegalMoves(Chess.initial),
            promotionMove: null,
            onMove: onMoveCallback,
            onPromotionSelection: onPieceSelectedCallback,
        )));
  }
}

void onMoveCallback(Move move, {bool? viaDragAndDrop}) => debugPrint(move.toString());
void onPieceSelectedCallback(Role? piece) => debugPrint(piece.toString());
