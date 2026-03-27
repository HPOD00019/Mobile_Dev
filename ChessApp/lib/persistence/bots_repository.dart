import 'package:chess/core/models/game_session.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class IBotsRepository {
  Set<BotOpponent> getBots();
}

@LazySingleton(as: IBotsRepository)
final class PersistantBotsRepository implements IBotsRepository{  
  @protected
  final List<BotOpponent> _bots = [
    BotOpponent(difficulty: BotDifficulty(level: 1)),
    BotOpponent(difficulty: BotDifficulty(level: 2)),
    BotOpponent(difficulty: BotDifficulty(level: 3)),
    BotOpponent(difficulty: BotDifficulty(level: 4)),
    BotOpponent(difficulty: BotDifficulty(level: 5)),
    BotOpponent(difficulty: BotDifficulty(level: 6)),
    BotOpponent(difficulty: BotDifficulty(level: 7)),
    BotOpponent(difficulty: BotDifficulty(level: 8)),
    BotOpponent(difficulty: BotDifficulty(level: 9)),
    BotOpponent(difficulty: BotDifficulty(level: 10)),
    ];
  
  @override
  Set<BotOpponent> getBots() => _bots.toSet(); 
}
