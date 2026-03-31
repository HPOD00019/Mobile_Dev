import 'package:chess/core/models/common/name.dart';
import 'package:chess/core/models/bot_difficulty.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class IBotsRepository {
  Set<BotOpponent> getBots();
  BotOpponent getByDifficultyLevel(int difficulty);
}

@LazySingleton(as: IBotsRepository)
final class PersistantBotsRepository implements IBotsRepository{  
  @protected
  final List<BotOpponent> _bots = [
    BotOpponent(
      difficulty: BotDifficulty(level: 1),
      displayName: Name.forceCreate("Bot (1)"),
    ),
    BotOpponent(
      difficulty: BotDifficulty(level: 2),
      displayName: Name.forceCreate("Bot (2)"),
    ),
    BotOpponent(
      difficulty: BotDifficulty(level: 3),
      displayName: Name.forceCreate("Bot (3)"),
    ),
    ];
  
  @override
  Set<BotOpponent> getBots() => _bots.toSet();
  
  @override
  BotOpponent getByDifficultyLevel(int difficulty) {
    return _bots.firstWhere((bot) => bot.difficulty.level == difficulty);
  } 
}
