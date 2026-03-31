
import 'package:chess/core/models/fen.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:dartchess/dartchess.dart';
import 'package:streamline/streamline.dart';

extension GameSessionExtensions on GameSession{
  
  GameSession withFen(Fen newFen) => copyWith(fen: newFen);
  GameSession withTurn(Side newTurn) => copyWith(turn: newTurn);
  GameSession withWinner(Side winner) => copyWith(
    status: GameStatus.completed,
    winner: Option.some(winner),
  );
}



