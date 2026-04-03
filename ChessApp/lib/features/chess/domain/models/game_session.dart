import 'package:chess/features/chess/domain/models/fen.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:dartchess/dartchess.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

final class SessionId extends Equatable{
  const SessionId._({required this.uuid});
  final String uuid;
  
  static SessionId createNew() => SessionId._(uuid: Uuid().v1());
  static SessionId restore({required String uuid}) {
    if(Uuid.isValidUUID(fromString: uuid)){
      return SessionId._(uuid: uuid);
    }
    throw UnimplementedError();
  }
  
  @override
  List<Object?> get props => [uuid];
}

enum OpponentType {bot,player}

final class SessionOpponent {
  SessionOpponent({required this.type, required this.id}); 
  final OpponentType type;
  final OpponentId id;
}


final class GameSession {
  const GameSession._({required this.id, required this.history, required this.black, required this.white});
 
  final SessionId id; 
  final List<Fen> history;
  
  final SessionOpponent black;
  final SessionOpponent white;
  
  static GameSession createNew(SessionOpponent white, SessionOpponent black) // with standart chess position
    => GameSession._(id: SessionId.createNew(), history: [Fen.initial], black: black, white: white); 

  Position getPosition() => Chess.fromSetup(Setup.parseFen(history.lastOrNull?.value ?? Fen.initial.value)); 
  
  GameSession addInHistory({required Fen fen}) =>
      _with(history: List.from([...history, fen]));

  GameSession _with({List<Fen>? history}) => GameSession._(
    id: id,
    history: history ?? this.history,
    black: black,
    white: white,
  );
}
