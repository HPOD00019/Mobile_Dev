
import 'package:chess/features/chess/domain/models/elo.dart';
import 'package:equatable/equatable.dart';

final class ChessProfile extends Equatable{
  const ChessProfile({required this.elo});
  
  final Elo elo;

  @override
  List<Object?> get props => [elo];
}
