import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/usecases/get_bot_turn_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_player_turn_usecase.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class GetOpponentTurnUsecase {
  const GetOpponentTurnUsecase({
    required this.getBotTurnUsecase,
    required this.getPlayerTurnUsecase,
  });

  final GetBotTurnUsecase getBotTurnUsecase;
  final GetPlayerTurnUsecase getPlayerTurnUsecase;

  Future<Result<Move, GetOpponentTurnFailure>> call({
    required Opponent opponent,
    required Position position,
  }) async {
    return switch (opponent) {
      BotOpponent bot => _getBotTurn(bot, position),
      HumanOpponent human => _getPlayerTurn(human, position),
      _ => Result.failure(
          const GetOpponentTurnFailure(message: 'Unknown opponent type'),
        ),
    };
  }

  Future<Result<Move, GetOpponentTurnFailure>> _getBotTurn(
    BotOpponent bot,
    Position position,
  ) async {
    final result = await getBotTurnUsecase(position);
    return result.mapError(
      (failure) => GetOpponentTurnFailure(message: failure.message),
    );
  }

  Future<Result<Move, GetOpponentTurnFailure>> _getPlayerTurn(
    HumanOpponent human,
    Position position,
  ) async {
    final result = await getPlayerTurnUsecase(position);
    return result.mapError(
      (failure) => GetOpponentTurnFailure(message: failure.message),
    );
  }
}

final class GetOpponentTurnFailure extends AppFailure {
  const GetOpponentTurnFailure({required this.message});

  final String message;
}
