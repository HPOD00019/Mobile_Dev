import 'package:chess/core/models/opponent.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:streamline/streamline.dart';

part 'get_bot_by_difficulty_query.mapper.dart';

@MappableClass()
final class GetBotByDifficultyQuery
    with GetBotByDifficultyQueryMappable
    implements IQuery<BotOpponent> {
  const GetBotByDifficultyQuery({required this.difficulty});
  
  final int difficulty;
}
