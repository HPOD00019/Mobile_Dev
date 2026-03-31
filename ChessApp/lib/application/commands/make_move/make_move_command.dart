import 'package:chess/core/models/game_session/game_session.dart';
import 'package:dartchess/dartchess.dart';
import 'package:streamline/streamline.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'make_move_command.mapper.dart';

@MappableClass()
class MakeMoveCommand 
  with MakeMoveCommandMappable
  implements ICommand<void> {
    
    const MakeMoveCommand(
    {
      required this.sessionId,
      required this.move
    });
    
  final SessionId sessionId;
  final Move move;
}

