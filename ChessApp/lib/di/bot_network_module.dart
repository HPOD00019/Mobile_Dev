// core/di/network_module.dart

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../features/chess/data/datasources/remote/api_client.dart';
import '../features/chess/data/datasources/remote/chess_remote_datasource.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  ApiClient apiClient(http.Client client) => ApiClient(
        baseUrl: 'http://localhost:5080/',
        client: client,
      );

  @lazySingleton
  ChessRemoteDataSource chessRemoteDataSource(ApiClient apiClient) =>
      ChessRemoteDataSource(
        baseUrl: 'http://localhost:5080/',
        apiClient: apiClient,
      );
}