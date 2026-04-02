import 'package:chess/application/queries/get_session/responses/get_session_response.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_session_by_id_queary.mapper.dart';

@MappableClass()
final class GetSessionByIdQueary
    with GetSessionByIdQuearyMappable
    implements IQuery<GetSessionResponse>
{
  final SessionId id;
  
  const GetSessionByIdQueary({required this.id});
}
