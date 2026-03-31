
class ChessProfileError implements Exception {}

final class InvalidProfileIdError implements ChessProfileError {
  @override
  String toString() => 'Id should be in uuid format!';
}
