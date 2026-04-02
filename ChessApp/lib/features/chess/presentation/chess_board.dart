import 'dart:math';
import 'package:chess/features/chess/domain/extensions/board_side_extensions.dart';
import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key, required this.state});
  
  final MatchState state;

  @override
  Widget build(BuildContext context) {    
    return _ChessBoard(state: state);
  }
}

final class _ChessBoard extends StatelessWidget {
  
  const _ChessBoard({required this.state});
  
  final MatchState state;
  
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
          orientation: state.userSide.getBoardOrientation(state.position.turn),
          fen: state.position.fen,
          game: GameData(
            playerSide: state.userSide,
            sideToMove: state.position.turn,
            validMoves: makeLegalMoves(state.position),
            promotionMove: state.moveToPromote,
            onMove: (move, {viaDragAndDrop}) => _onMoveHandle(context, move, viaDragAndDrop),
            onPromotionSelection: (piece) => _onPromotion(context, piece),
          ),
        );
      },
    );
  }
    
  
  void _onMoveHandle(BuildContext context, Move move, bool? viaDragAndDrop) {
    context.read<ChessMatchBloc>()
    .add(
      MoveRequested(move: move)
    );
  }
  
  void _onPromotion(BuildContext context, Role? piece) {
    context.read<ChessMatchBloc>().add(MoveRequested(move: state.moveToPromote!));
  }
}
