import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants.dart';

typedef ResponseFuture<T> = Future<Response<T>>;

@lazySingleton
class ChessApi {
  ChessApi(): _dio = dioConfiguration;

  final Dio _dio;
  
  // TODO: dynamic -> response dto
  ResponseFuture getSessionByIdAsync(String id) => _dio.get<dynamic>(ApiConfig.handles.session(id));
}

Dio get dioConfiguration => Dio(
  BaseOptions(
    baseUrl: ApiConfig.chess_api,
    connectTimeout: const Duration(milliseconds: ApiConfig.timeout),
    receiveTimeout: const Duration(milliseconds: ApiConfig.timeout),
  ),
);
