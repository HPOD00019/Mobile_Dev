
import 'package:dartchess/dartchess.dart';

extension MoveExtensions on Move {
  bool isPromotionPawnMove(Position position) {
    return switch (this) {
      NormalMove move => move.promotion == null && position.board.roleAt(move.from) == Role.pawn &&
      ((move.to.rank == Rank.first && position.turn == Side.black) || (move.to.rank == Rank.eighth && position.turn == Side.white)),
      
      _ => false
    };
  }
}
