import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:equatable/equatable.dart';

final class MatchResult extends Equatable {
  const MatchResult({
    required this.winner,
    required this.loser,
    required this.reason,
  });

  final Opponent? winner; // null for draw
  final Opponent? loser;  // null for draw
  final String reason;

  bool get isDraw => winner == null && loser == null;

  @override
  List<Object?> get props => [winner, loser, reason];
}
