
import 'package:chess/application/queries/get_session/get_session_queary.dart';
import 'package:chess/core/models/game_session.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class GetSessionQuearyHandler implements IQueryHandler<GetSessionQueary, GameSession>{
  // TODO: GetSessionQuearyHandler(GameSessionsRepository repository); (resolved by AoC)

  @override
  Future<GameSession> handle(GetSessionQueary query) {
    // TODO: This is the mock, actual value should be fetched by id from repository
    return Future.value(
      GameSession(
        sessionId: query.sessionId, 
        turn: Side.white, 
        playerSide: PlayerSide.white,
        fen: (value: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')));
  }
}
