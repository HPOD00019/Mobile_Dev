import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';

extension BoardSideExtensions on PlayerSide{
  Side getBoardOrientation(Side turn) => switch (this) {
    PlayerSide.none => Side.white,
    PlayerSide.both => turn,
    PlayerSide.white => Side.white,
    PlayerSide.black => Side.black,
  };
}
