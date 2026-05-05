import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/usecases/make_move_usecase.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MakeMoveUsecase usecase;

  setUp(() {
    usecase = MakeMoveUsecase();
  });

  test('should return new position when move is played', () async {
    // Arrange
    final position = Chess.initial;
    // Square.e2 and Square.e4 are constants from dartchess
    final move = NormalMove(from: Square.e2, to: Square.e4);
    final params = MoveParams(move: move, position: position);

    // Act
    final result = await usecase(params);

    // Assert
    expect(result is Success, true);
    final newPosition = (result as Success).value;
    expect(newPosition.fen, isNot(position.fen));
    expect(newPosition.board.roleAt(Square.e4), Role.pawn);
    expect(newPosition.board.sideAt(Square.e4), Side.white);
  });

  test('should return failure when move is illegal', () async {
    // Arrange
    final position = Chess.initial;
    // Illegal move for white (e.g., e2 to e5)
    final move = NormalMove(from: Square.e2, to: Square.e5);
    final params = MoveParams(move: move, position: position);

    // Act
    final result = await usecase(params);

    // Assert
    expect(result is Failure, true);
  });
}
