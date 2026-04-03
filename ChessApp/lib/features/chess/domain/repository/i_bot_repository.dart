import 'package:chess/features/chess/domain/models/opponent.dart';

abstract class IBotRepository {
  Future<Iterable<BotOpponent>> getAll();
  
  Future<BotOpponent> getById(OpponentId id);
}
