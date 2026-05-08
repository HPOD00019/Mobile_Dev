import 'package:dart_mappable/dart_mappable.dart';

part 'chess_engine_response.mapper.dart';

@MappableClass()
final class ChessEngineResponse with ChessEngineResponseMappable {
  const ChessEngineResponse({required this.uci});

  @MappableField(key: 'move')
  final String uci;
}
