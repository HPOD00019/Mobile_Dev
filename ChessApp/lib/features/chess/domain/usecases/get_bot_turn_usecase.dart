import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/extensions/move_extensions.dart';
import 'package:chess/http/configure_dio.dart';
import 'package:chess/http/response/chess_engine_response.dart';
import 'package:dartchess/dartchess.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class GetBotTurnUsecase {
  Future<Result<Move, GetBotTurnFailure>> call(Position position) async {
    
    try {
      var response = await http.post(
        "https://chess-api.com/v1",
        data: {'fen': position.fen},
        options: Options(receiveTimeout: Duration(seconds: 5)),
      );
      var engineResponse = ChessEngineResponseMapper.fromMap(response.data);

      Move? move = Move.parse(engineResponse.uci);

      if (move == null) throw Exception("Was unable to parse UCI move returned by api...");

      return Result.success(move);
    } catch (e) {
      debugPrint("Failed to get bot move from api. Fallback to internal bot implementation.");
    }

    // Fallback bot logic in case api not working
    try {
      // Emulate bot thinking delay
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
      
      Move move = NormalMove(from: randomEntry.key, to: randomTo);

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
