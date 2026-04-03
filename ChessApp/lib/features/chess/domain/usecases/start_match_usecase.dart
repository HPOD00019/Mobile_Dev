import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class StartMatchUseCase {
  const StartMatchUseCase({
    required this.botsRepository,
    required this.sessionsRepository,
    required this.getAppUserUsecase,
  });

  final IBotRepository botsRepository;
  final ISessionRepository sessionsRepository;
  final GetAppUserUsecase getAppUserUsecase;

  Future<Result<MatchStartResult, StartMatchFailure>> call(
    BotOpponent bot, {
    bool forceCreate = false,
  }) async {
    final appUserResult = await getAppUserUsecase(NoParams());

    if (appUserResult is Failure<HumanOpponent, GetAppUserFailure>) {
      return Result.failure(StartMatchFailure(message: 'Failed to get current user'));
    }

    final appUser = appUserResult.value;

    if (!forceCreate) {
      final sessions = await sessionsRepository.getAll();

      final existingSession = sessions.where((session) {
        final isBotInSession = (session.white.type == OpponentType.bot && session.white.id == bot.id) ||
            (session.black.type == OpponentType.bot && session.black.id == bot.id);
        final isUserInSession = (session.white.type == OpponentType.player && session.white.id == appUser.id) ||
            (session.black.type == OpponentType.player && session.black.id == appUser.id);
        return isBotInSession && isUserInSession;
      }).firstOrNull;

      if (existingSession != null) {
        return Result.success(MatchStartResult.hasExistingSession(existingSession));
      }
    }

    final sessionId = await sessionsRepository.create(
      SessionOpponent(type: OpponentType.player, id: appUser.id),
      SessionOpponent(type: OpponentType.bot, id: bot.id),
    );

    return Result.success(MatchStartResult.newMatchCreated(sessionId));
  }
}

final class StartMatchFailure extends AppFailure {
  const StartMatchFailure({required this.message});
  
  final String message;
}

final class MatchStartResult {
  const MatchStartResult._({
    this.existingSession,
    this.newSessionId,
  });

  factory MatchStartResult.hasExistingSession(GameSession session) {
    return MatchStartResult._(existingSession: session);
  }

  factory MatchStartResult.newMatchCreated(SessionId sessionId) {
    return MatchStartResult._(newSessionId: sessionId);
  }

  final GameSession? existingSession;
  final SessionId? newSessionId;

  bool get alreadyExist => existingSession != null;
  bool get isNewMatch => newSessionId != null;
}
