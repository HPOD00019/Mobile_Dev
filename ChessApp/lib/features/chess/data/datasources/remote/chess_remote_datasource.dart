import 'package:chess/core/errors/exceptions.dart';
import 'package:chess/features/chess/data/models/move_request.dart';
import 'package:chess/features/chess/data/models/move_response.dart';

import 'api_client.dart';
import 'package:chess/core/utilities/result.dart';

class ChessRemoteDataSource {
  final ApiClient _apiClient;
  final String baseUrl;

  ChessRemoteDataSource({
    required this.baseUrl,
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  Future<Result<String, ServerException>> getMove(String fen) async {
    try {
      final request = MoveRequest(fen: fen);
      final result = await _apiClient.post('ChessEngine/GetBestMove', body: request.toJson());
      print('POST $baseUrl -> $result');
      final moveResponse = MoveResponse.fromJson(result as Map<String, dynamic>);
      return Result.success(moveResponse.bestMove);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(ServerException(message: e.toString()));
    }
  }
}