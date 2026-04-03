
import 'package:chess/features/chess/domain/models/game_session.dart';

abstract class ISessionRepository {
  Future<Iterable<GameSession>> getAll();

  /// Returns snapshot if found. Otherwise throws [SessionNotFoundException].
  Future<GameSession> getById(SessionId id);

  Future<SessionId> create(SessionOpponent white, SessionOpponent black);

  Future<void> update(GameSession session);
}
