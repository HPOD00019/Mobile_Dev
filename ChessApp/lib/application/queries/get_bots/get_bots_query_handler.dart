
import 'package:chess/application/queries/get_bots/get_bots_query.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chess/persistence/bots_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class GetBotsQueryHandler
    implements IQueryHandler<GetBotsQuery, Set<BotOpponent>> {
  const GetBotsQueryHandler(this._repository);

  final IBotsRepository _repository;

  @override
  Future<Set<BotOpponent>> handle(GetBotsQuery query) {
    return Future.value(_repository.getBots());
  }
}
