import 'package:chess/core/usecases/usecase.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/errors/failures.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';

final class MoveParams {
  const MoveParams({required this.move, required this.position});
  final Move move;
  final Position position;
}

@lazySingleton
class MakeMoveUsecase extends UseCase<Position, MoveParams> {
  @override
  Future<Result<Position, ChessMoveFailure>> call(MoveParams params) async {
    try{
      return Result.success(params.position.play(params.move));    
    } 
    on Exception catch (e) {
      return Result.failure(UnknownChessMoveFailure(error: e.toString()));
    }
  }
}
