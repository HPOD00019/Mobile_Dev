import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_current_fen_queary.mapper.dart';

@MappableClass()
class GetCurrentFenQueary
    with GetCurrentFenQuearyMappable
    implements IQuery<String> {
  final String sessionId;

  const GetCurrentFenQueary({required this.sessionId});
}
