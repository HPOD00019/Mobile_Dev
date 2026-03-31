import 'package:chess/core/models/game_session/game_session.dart';
import 'package:streamline/streamline.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'leave_session_command.mapper.dart';

@MappableClass()
class LeaveSessionCommand
  with LeaveSessionCommandMappable
  implements ICommand<void> {

  const LeaveSessionCommand({
    required this.sessionId,
  });

  final SessionId sessionId;
}
