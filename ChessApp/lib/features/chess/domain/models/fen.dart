import 'package:equatable/equatable.dart';

final class Fen extends Equatable {
  const Fen({required this.value});
  
  final String value;
  
  @override
  String toString() => value;
  @override
  List<Object?> get props => [value];
  
  // static Fen initial = const Fen(value: "r1bqkb1r/pppp1ppp/2n2n2/4p2Q/2B1P3/8/PPPP1PPP/RNB1K1NR w KQkq - 4 4"); 
  static Fen initial = const Fen(value: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"); 
}
