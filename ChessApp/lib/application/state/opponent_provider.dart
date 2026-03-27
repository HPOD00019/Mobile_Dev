import 'package:chess/core/models/game_session.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

abstract class IOpponentProvider {
  Opponent getOpponent();
  void setOpponent(Opponent value);
}

@LazySingleton(as: IOpponentProvider)
final class OpponentProvider implements IOpponentProvider {

  @protected
  Opponent _opponent = BotOpponent(difficulty: BotDifficulty(level: 1));

  @override
  Opponent getOpponent() => _opponent;
  @override
  void setOpponent(Opponent value) => _opponent = value;
}
