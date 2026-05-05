import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateMatchUseCase {
  const CreateMatchUseCase({
    required this.sessionsRepository,
  });

  final ISessionRepository sessionsRepository;

  Future<Result<SessionId, CreateMatchFailure>> call({
    required SessionOpponent white,
    required SessionOpponent black,
  }) async {
    final sessionId = await sessionsRepository.create(white, black);
    return Result.success(sessionId);
  }
}

final class CreateMatchFailure extends AppFailure {
  const CreateMatchFailure({required this.message});

  final String message;
}
