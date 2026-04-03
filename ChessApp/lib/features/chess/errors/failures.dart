import 'package:chess/core/errors/failure.dart';

class ChessMoveFailure extends AppFailure {}

final class UnknownChessMoveFailure extends ChessMoveFailure {
  UnknownChessMoveFailure({required this.error});
  final String error;
}

class GetSessionFailure extends AppFailure {}
final class SessionNotFoundFailure extends GetSessionFailure {}
final class InternalError extends GetSessionFailure {}
