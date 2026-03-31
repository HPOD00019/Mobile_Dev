
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'game_session_state_changed_event.mapper.dart';

@MappableClass()
final class GameSessionStateChangedEvent 
  with GameSessionStateChangedEventMappable
  implements IEvent {
}
