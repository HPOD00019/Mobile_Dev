
import 'package:chess/core/errors/session_errors.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:injectable/injectable.dart';

abstract class ISessionRepository {
  GameSession getById(SessionId id);
  GameSession add(GameSession session);
  void update(GameSession session);
}

@LazySingleton(as: ISessionRepository)
final class OfflineSessionRepository implements ISessionRepository{

  List<GameSession> sessions = [];

  @override
  GameSession getById(SessionId id) {
    for (var session in sessions) {
      if(session.sessionId == id){return session;}
    }
    throw SessionNotFoundError();
  }

  @override
  GameSession add(GameSession session) {
    sessions.add(session);
    return session;
  }

  @override
  void update(GameSession session) {
    final index = sessions.indexWhere((s) => s.sessionId == session.sessionId);
    if (index == -1) {
      throw SessionNotFoundError();
    }
    sessions[index] = session;
  }
}


