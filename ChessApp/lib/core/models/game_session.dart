import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';

typedef SessionId = ({String value});
typedef Fen = ({String value});

final class GameSession {
  final SessionId sessionId;
  final Side turn;
  final PlayerSide playerSide;
  final Fen fen;
    
  const GameSession({
    required this.sessionId, 
    required this.turn,
    required this.playerSide,
    required this.fen});
}

extension PlayerSideExtensions on PlayerSide {
  Side getOrientetion(Side turn) => switch (this){   
    PlayerSide.none => turn, // <- spectating from both points of view
    PlayerSide.both => turn, // <- playing on both sides
    PlayerSide.white => Side.white, // <- inspect only your own side
    PlayerSide.black => Side.black  // <- inspect only your own side
  };
}
