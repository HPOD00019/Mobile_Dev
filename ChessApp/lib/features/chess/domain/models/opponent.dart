import 'package:chess/features/chess/domain/models/chess_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';


final class OpponentId extends Equatable{
  const OpponentId._({required this.uuid});
  final String uuid;
  
  static OpponentId createNew() => OpponentId._(uuid: Uuid().v1());
  static OpponentId restore({required String uuid}) => OpponentId._(uuid: uuid);
  
  @override
  List<Object?> get props => [uuid];
}

abstract class Opponent extends Equatable {
  const Opponent({required this.id, required this.displayName});
  
  final OpponentId id;
  final String displayName;
  
  @override
  List<Object?> get props => [id.uuid]; // opponent1 equals opponent2 if id the same
}

final class HumanOpponent extends Opponent{
  const HumanOpponent({required super.id,  required super.displayName, required this.profile});
  
  final ChessProfile profile;
}


final class BotOpponent extends Opponent{
  const BotOpponent({required super.id,  required super.displayName, required this.difficulty}); 
  
  final int difficulty; 
}

extension BotExtensions on BotOpponent {
  String getLabelForDifficulty() => switch (difficulty) {
    <= 3 => "Easy",
    <= 6 => "Medium",
    _ => "Hard"
  };
}
