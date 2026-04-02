import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chessground/chessground.dart';

extension GameSessionExtensions on GameSession {
  PlayerSide getUserSide(OpponentId userId) {
    if (white.id == userId && black.id == userId) return PlayerSide.both;
    if (white.id == userId) return PlayerSide.white;
    if (black.id == userId) return PlayerSide.black;
    return PlayerSide.none;
  } 
}
