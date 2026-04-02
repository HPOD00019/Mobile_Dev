import 'package:equatable/equatable.dart';

final class Fen extends Equatable {
  const Fen({required this.value});
  
  final String value;
  
  @override
  String toString() => value;
  @override
  List<Object?> get props => [value];
  
  static Fen initial = const Fen(value: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"); 
}
