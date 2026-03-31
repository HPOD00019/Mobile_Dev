
final class AppUserError implements Exception {}

final class InvalidUserIdError implements AppUserError{
  @override
  String toString() => 'Id should be in uuid format!';
}

final class InvalidChessProfile implements AppUserError {}
