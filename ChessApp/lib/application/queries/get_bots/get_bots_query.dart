import 'package:chess/core/models/opponent.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_bots_query.mapper.dart';

@MappableClass()
final class GetBotsQuery
    with GetBotsQueryMappable
    implements IQuery<Set<BotOpponent>> {
  const GetBotsQuery();
}
