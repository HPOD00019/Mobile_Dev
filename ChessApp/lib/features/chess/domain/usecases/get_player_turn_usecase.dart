import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/usecases/usecase.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class GetPlayerTurnUsecase extends UseCase<Move, Position> {
  @override
  Future<Result<Move, GetPlayerTurnFailure>> call(Position params) async {
    throw UnimplementedError(
      'Player turn via websockets is not yet implemented',
    );
  }
}

final class GetPlayerTurnFailure extends AppFailure {
  const GetPlayerTurnFailure({required this.message});

  final String message;
}
