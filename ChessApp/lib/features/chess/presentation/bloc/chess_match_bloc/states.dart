import 'package:chess/features/chess/domain/models/match_state.dart';

final class ChessMatchBlocState {}

final class EmptyState implements ChessMatchBlocState {}
final class InternalError implements ChessMatchBlocState {
  final String error;

  InternalError({required this.error});
}
final class MatchStateActive implements ChessMatchBlocState {  
  final MatchState state;
  MatchStateActive({required this.state});
}

