import 'package:chess/features/chess/domain/models/fen.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/errors/exceptions.dart';
import 'package:chess/features/chess/persistence/repository/game_session_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GameSessionRepository repository;

  setUp(() {
    repository = GameSessionRepository();
  });

  final tWhite = SessionOpponent(id: OpponentId.restore(uuid: 'white'), type: OpponentType.player);
  final tBlack = SessionOpponent(id: OpponentId.restore(uuid: 'black'), type: OpponentType.bot);

  test('should create and retrieve a session', () async {
    // Act
    final id = await repository.create(tWhite, tBlack);
    final session = await repository.getById(id);

    // Assert
    expect(session.id, id);
    expect(session.white.id.uuid, 'white');
    expect(session.black.id.uuid, 'black');
  });

  test('should throw SessionNotFoundException when session does not exist', () async {
    // Arrange
    final nonExistentId = SessionId.restore(uuid: '550e8400-e29b-41d4-a716-446655440001');

    // Act & Assert
    expect(() => repository.getById(nonExistentId), throwsA(isA<SessionNotFoundException>()));
  });

  test('should update an existing session', () async {
    // Arrange
    final id = await repository.create(tWhite, tBlack);
    final session = await repository.getById(id);
    final updatedSession = session.addInHistory(fen: const Fen(value: 'new fen'));

    // Act
    await repository.update(updatedSession);
    final result = await repository.getById(id);

    // Assert
    expect(result.history.last.value, 'new fen');
  });
}
