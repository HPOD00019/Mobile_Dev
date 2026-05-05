import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/usecases/usecase.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/match_result.dart';
import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MatchResultEvaluateUseCase extends UseCase<MatchResult, MatchState> {
  @override
  Future<Result<MatchResult, MatchResultEvaluateFailure>> call(
    MatchState params,
  ) async {
    final position = params.position;

    if (!position.isGameOver) {
      return Result.failure(
        const MatchResultEvaluateFailure(
          message: 'Cannot evaluate match result for a game that is not over',
        ),
      );
    }

    final reason = _determineReason(position);
    final (winner, loser) = _determineWinnerAndLoser(params, position);

    return Result.success(
      MatchResult(winner: winner, loser: loser, reason: reason),
    );
  }

  String _determineReason(Position position) {
    if(position.isCheckmate) return "Checkmate";
    if(position.isStalemate) return "Stalemate";
    if(position.isInsufficientMaterial) return "Insufficient material";
    if(position.isVariantEnd) return "Variant end";
    
        return 'Game over';
  }

  (Opponent?, Opponent?) _determineWinnerAndLoser(
    MatchState state,
    Position position,
  ) {
    if (position.outcome == null) return (null, null);
    if (position.outcome == Outcome.draw) return (null, null);
    
    if (position.outcome == Outcome.whiteWins) return (state.white, state.black);
    if (position.outcome == Outcome.blackWins) return (state.black, state.white);
    
    return (null, null);
  }
}

final class MatchResultEvaluateFailure extends AppFailure {
  const MatchResultEvaluateFailure({required this.message});
  final String message;
}
