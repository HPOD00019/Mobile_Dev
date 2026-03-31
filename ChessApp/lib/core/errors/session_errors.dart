abstract class SessionRepositoryError{
  const SessionRepositoryError();
}

final class SessionNotFoundError extends SessionRepositoryError
    implements Exception {}
    
final class UnexpectedSessionError extends SessionRepositoryError
    implements Exception {}
