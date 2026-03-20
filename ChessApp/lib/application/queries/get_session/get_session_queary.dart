
import 'package:chess/core/models/game_session.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_session_queary.mapper.dart';

@MappableClass()
final class GetSessionQueary 
  with GetSessionQuearyMappable
  implements IQuery<GameSession>
{
  final SessionId sessionId;
  
  const GetSessionQueary({required this.sessionId});
}
