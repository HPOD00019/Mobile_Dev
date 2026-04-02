import 'dart:collection';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/errors/exceptions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISessionRepository)
final class GameSessionRepository implements ISessionRepository{
  
  HashSet<GameSession> sessions = HashSet.from([]);
  
  @override
  Future<Iterable<GameSession>> getAll() async {
    return sessions.toList();
  }

  @override
  Future<GameSession> getById(SessionId id) async {
    for (var session in sessions) {
      if(session.id == id) {return session;}
    }
    throw SessionNotFoundException();
  }
  
  @override
  Future<SessionId> create(SessionOpponent white, SessionOpponent black) async{
    var session = GameSession.createNew(white, black);
    sessions.add(session);
    return session.id;
  }
}
