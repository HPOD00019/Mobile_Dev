import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';

/// State for chess match widgets 
final class MatchState {
  final SessionId relatedSessionId;
  final Position position;
  final PlayerSide userSide;
  final Opponent white;
  final Opponent black;
  
  // Chessboard library forced me to do that!
  NormalMove? moveToPromote;

  MatchState({required this.position, required this.userSide, required this.white, required this.black, required this.relatedSessionId});
  MatchState _with({Position? position, PlayerSide? userSide}) => MatchState(
    position: position ?? this.position,
    userSide: userSide ?? this.userSide, 
    white: white, 
    black: black,
     relatedSessionId: relatedSessionId,
  );
  
  MatchState withPosition({required Position position}) => _with(position: position);
  
  @override
  String toString() => "[FEN]: ${position.fen}";
}

extension MatchStateExtensions on MatchState {
  Opponent getTurnTaker(Side turn) =>
      turn == Side.white ? white : black;
}
