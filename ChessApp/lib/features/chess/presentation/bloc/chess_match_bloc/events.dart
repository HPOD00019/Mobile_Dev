import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:dartchess/dartchess.dart';

final class ChessMatchBlocEvent {}

final class MoveRequested implements ChessMatchBlocEvent {
  MoveRequested({required this.move});
  final Move move;
}

final class LoadMatchRequested implements ChessMatchBlocEvent {
  LoadMatchRequested({required this.sessionId});
  final SessionId sessionId;
}

final class TurnChanged implements ChessMatchBlocEvent {
  const TurnChanged();
}
