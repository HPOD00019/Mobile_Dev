import 'package:chess/application/queries/get_bot_by_difficulty/get_bot_by_difficulty_query.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chess/persistence/bots_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class GetBotByDifficultyQueryHandler
    implements IQueryHandler<GetBotByDifficultyQuery, BotOpponent> {
  const GetBotByDifficultyQueryHandler(this._repository);

  final IBotsRepository _repository;

  @override
  Future<BotOpponent> handle(GetBotByDifficultyQuery query) {
    return Future.value(_repository.getByDifficultyLevel(query.difficulty));
  }
}
