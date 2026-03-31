

import 'package:chess/core/models/fen.dart';
import 'package:chess/core/models/game_session/factories.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:dartchess/dartchess.dart';
import 'package:streamline/streamline.dart';

extension GameSessionExtensions on GameSession{
  GameSession applyMove(Move move) {
    
    final chess = Chess.fromSetup(Setup.parseFen(fen.value));
    final newFen = Fen(value: chess.play(move).fen);
    final newTurn = turn == Side.white ? Side.black : Side.white;

    if (chess.isCheckmate) {
      return withFen(newFen).withWinner(turn);
    }

    if (chess.isStalemate || chess.isInsufficientMaterial) {
      return copyWith(
        fen: newFen,
        status: GameStatus.completed,
        winner: Option.none(),
      );
    }

    return copyWith(fen: newFen, turn: newTurn);
  }
}
