// ignore_for_file: constant_identifier_names


final class Handles {
  
  String session(String id) => '/game/session/$id';
  
  const Handles();
}

final class ApiConfig {
  static const String chess_api = 'https://api.chessbot.com';
  static const int timeout = 30000;
  
  static const Handles handles = Handles();
}
