import 'package:chess/core/models/opponent.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_opponent_query.mapper.dart';

@MappableClass()
final class GetOpponentQuery 
  with GetOpponentQueryMappable
  implements IQuery<Opponent> {
    
  const GetOpponentQuery();
}
