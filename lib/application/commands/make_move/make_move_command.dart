import 'package:streamline/streamline.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'make_move_command.mapper.dart';

@MappableClass()
class MakeMoveCommand 
  with MakeMoveCommandMappable
  implements ICommand<String> {
    
    const MakeMoveCommand(
    {
      required this.sessionId,
      required this.fen
    });
    
    final String sessionId;
    final String fen;
}
