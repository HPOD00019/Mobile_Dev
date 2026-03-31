import 'package:chess/core/models/chess_profile.dart';
import 'package:chess/core/models/common/name.dart';
import 'package:chess/core/models/bot_difficulty.dart';
import 'package:dartchess/dartchess.dart';
import 'package:streamline/streamline.dart';

abstract class Opponent {
  const Opponent({required this.displayName}) : playsFor = const Option.none();
  const Opponent._({required this.displayName, required this.playsFor});

  final Name displayName;
  final Option<Side> playsFor;

  Opponent withColor(Side color);
}

final class BotOpponent extends Opponent {
  final BotDifficulty difficulty;

  const BotOpponent({required this.difficulty, required super.displayName});

  @override
  BotOpponent withColor(Side color) => BotOpponent._(
    displayName: displayName,
    difficulty: difficulty,
    playsFor: Option.some(color),
  );

  const BotOpponent._({
    required this.difficulty,
    required super.displayName,
    required super.playsFor,
  }) : super._();
}

final class HumanOpponent extends Opponent {
  final ChessProfile profile;

  HumanOpponent({required super.displayName, required this.profile});

  @override
  HumanOpponent withColor(Side color) => HumanOpponent._(
    displayName: displayName,
    profile: profile,
    playsFor: Option.some(color),
  );

  const HumanOpponent._({
    required super.displayName,
    required this.profile,
    required super.playsFor,
  }) : super._();
}

extension BotOpponentExtensions on BotOpponent{
  // ignore: avoid_init_to_null
  String getLabelForDifficulty({String Function(BotOpponent)? locale = null}) {
    if(locale != null) {
      return locale(this);
    }
  
    return switch (difficulty.level){
      <= 3 => 'Easy',
      <= 6 => 'Medium',
      _ => 'Hard'
    };
  }
}
