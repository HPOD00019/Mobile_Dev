import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/errors/exceptions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISessionRepository)
final class GameSessionRepository implements ISessionRepository{

  final Map<SessionId, GameSession> sessions = {};

  @override
  Future<Iterable<GameSession>> getAll() async {
    return sessions.values;
  }

  @override
  Future<GameSession> getById(SessionId id) async {
    final session = sessions[id];
    if (session != null) return session;
    throw SessionNotFoundException();
  }

  @override
  Future<SessionId> create(SessionOpponent white, SessionOpponent black) async{
    var session = GameSession.createNew(white, black);
    sessions[session.id] = session;
    return session.id;
  }

  @override
  Future<void> update(GameSession session) async {
    sessions[session.id] = session;
  }
}
