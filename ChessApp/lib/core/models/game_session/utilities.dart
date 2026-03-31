import 'package:chess/core/models/game_session/game_session.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';

extension GameSessionExtensions on GameSession {
  
  bool isUserTurn() => switch (userSide) {
    PlayerSide.none => false,
    PlayerSide.both => true,
    PlayerSide.white => turn == Side.white,
    PlayerSide.black => turn == Side.black,
  };
  
  Side getBoardOrientation() => switch (userSide) {
    PlayerSide.none => turn, // <- spectating from both points of view
    PlayerSide.both => turn, // <- playing on both sides
    PlayerSide.white => Side.white, // <- inspect only your own side
    PlayerSide.black => Side.black, // <- inspect only your own side
  };
}
