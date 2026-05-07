import 'package:chess/core/errors/exceptions.dart';
import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/extensions/move_extensions.dart';
import 'package:chess/features/chess/data/datasources/remote/chess_remote_datasource.dart';
import 'package:dartchess/dartchess.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

@lazySingleton
final class GetBotTurnUsecase {
  final ChessRemoteDataSource _dataSource;

  GetBotTurnUsecase({required ChessRemoteDataSource dataSource}) 
    : _dataSource = dataSource;

  Future<Result<Move, GetBotTurnFailure>> call(Position position) async {
    try {
      
      final result = await _dataSource.getMove(position.fen);

      final String bestMove;

      switch (result) {
        case Success(value: final move):
          bestMove = move;
        case Failure(error: final failure):
          print(failure);
          return Result.failure(
            GetBotTurnFailure(message: failure.message),
          );
      }

 
      // Simulate bot thinking delay
      await Future.delayed(Duration(milliseconds: 500));
      
      final legalMaps = position.legalMoves;
      if (legalMaps.isEmpty) {
        return Result.failure(
          const GetBotTurnFailure(message: 'No legal moves available'),
        );
      }

      // Filter out empty SquareSets and collect all valid from-squares
      final validFromSquares = legalMaps.entries
          .where((e) => e.value.size > 0)
          .toList();

      if (validFromSquares.isEmpty) {
        return Result.failure(
          const GetBotTurnFailure(message: 'No legal moves available'),
        );
      }

      final random = DateTime.now().millisecondsSinceEpoch;
      final randomEntry = validFromSquares[random % validFromSquares.length];
      final toSquares = randomEntry.value;

      final randomTo = toSquares.squares
          .toList()
          .elementAt(random % toSquares.size.toInt());

      // Construct the move
      Move move = NormalMove.fromUci(bestMove);

      // Handle promotion - always pick queen
      if (move.isPromotionPawnMove(position) && move is NormalMove) {
        move = move.withPromotion(Role.queen);
      }

      return Result.success(move);
    } on Exception catch (e) {
      return Result.failure(
        GetBotTurnFailure(message: 'Failed to get bot turn: $e'),
      );
    }
  }
}

final class GetBotTurnFailure extends AppFailure {
  const GetBotTurnFailure({required this.message});

  final String message;
}