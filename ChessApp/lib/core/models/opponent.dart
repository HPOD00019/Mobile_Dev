import 'package:chess/core/models/game_session.dart';

abstract class Opponent {
  const Opponent();
}

final class HumanOpponent extends Opponent {}

final class BotOpponent extends Opponent {
  final BotDifficulty difficulty;

  const BotOpponent({required this.difficulty});
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
