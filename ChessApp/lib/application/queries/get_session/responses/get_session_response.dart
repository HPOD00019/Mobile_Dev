import 'package:chess/core/models/game_session/game_session.dart';

abstract class GetSessionResponse {
  const GetSessionResponse();
}
final class NotFound extends GetSessionResponse {}

final class Found extends GetSessionResponse {
  const Found({required this.session});
  final GameSession session;
}
