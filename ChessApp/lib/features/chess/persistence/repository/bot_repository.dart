import 'dart:collection';

import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBotRepository)
final class BotRepository implements IBotRepository {

  final HashSet<BotOpponent> _bots = HashSet.from([
    BotOpponent(id: OpponentId.createNew(), displayName: "Tyler", difficulty: 1),
    BotOpponent(id: OpponentId.createNew(), displayName: "Josh", difficulty: 2),
    BotOpponent(id: OpponentId.createNew(), displayName: "Wolt", difficulty: 3),
  ]);
  
  @override
  Future<Iterable<BotOpponent>> getAll() async {
    return _bots.toList();
  }

  @override
  Future<BotOpponent> getById(OpponentId id) async {
    for (var bot in _bots) {
      if(bot.id == id) return bot;
    }
    throw Exception("Bot not found!");
  }
}
