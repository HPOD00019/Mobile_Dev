import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'fen_changed_event.mapper.dart';

@MappableClass()
class GameFenChangedEvent with GameFenChangedEventMappable implements IEvent {
  final String sessionId;
  final String fen;

  const GameFenChangedEvent({required this.sessionId, required this.fen});
}
