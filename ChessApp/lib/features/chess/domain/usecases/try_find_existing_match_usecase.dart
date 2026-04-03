import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class TryFindExistingMatchUseCase {
  const TryFindExistingMatchUseCase({
    required this.sessionsRepository,
    required this.getAppUserUsecase,
  });

  final ISessionRepository sessionsRepository;
  final GetAppUserUsecase getAppUserUsecase;

  Future<Result<GameSession, FindExistingMatchFailure>> call(
    Opponent opponent,
  ) async {
    final appUserResult = await getAppUserUsecase(NoParams());

    if (appUserResult is Failure<HumanOpponent, GetAppUserFailure>) {
      return Result.failure(
        const UserNotAuthenticated(),
      );
    }

    final appUser = appUserResult.value;

    final sessions = await sessionsRepository.getAll();

    final existingSession = sessions.where((session) {
      final isOpponentInSession = (session.white.id == opponent.id) || (session.black.id == opponent.id);
      final isUserInSession = (session.white.id == appUser.id) || (session.black.id == appUser.id);
      return isOpponentInSession && isUserInSession;
    }).firstOrNull;

    if (existingSession != null) {
      return Result.success(existingSession);
    }

    return Result.failure(
      const NoActiveMatch(),
    );
  }
}

sealed class FindExistingMatchFailure extends AppFailure {
  const FindExistingMatchFailure({required this.message});

  final String message;
}

final class NoActiveMatch extends FindExistingMatchFailure {
  const NoActiveMatch() : super(message: 'No active match found');
}

final class UserNotAuthenticated extends FindExistingMatchFailure {
  const UserNotAuthenticated() : super(message: 'Failed to get current user');
}
