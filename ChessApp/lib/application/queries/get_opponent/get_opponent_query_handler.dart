import 'package:chess/application/queries/get_opponent/get_opponent_query.dart';
import 'package:chess/application/state/opponent_provider.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class GetOpponentQueryHandler
    implements IQueryHandler<GetOpponentQuery, Opponent> {

  const GetOpponentQueryHandler(this._opponent);

  final IOpponentProvider _opponent;

  @override
  Future<Opponent> handle(GetOpponentQuery query) {
    return Future.value(_opponent.getOpponent());
  }
}
