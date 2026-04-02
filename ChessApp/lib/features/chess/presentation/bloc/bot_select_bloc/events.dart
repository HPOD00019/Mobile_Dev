import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:equatable/equatable.dart';

abstract class BotSelectBlocEvent extends Equatable {
  const BotSelectBlocEvent();

  @override
  List<Object?> get props => [];
}

final class BotOptionsRequested extends BotSelectBlocEvent {
  const BotOptionsRequested();
}

final class BotSelected extends BotSelectBlocEvent {
  const BotSelected({required this.bot});

  final BotOpponent bot;

  @override
  List<Object?> get props => [bot];
}

final class MatchRequested extends BotSelectBlocEvent {
  const MatchRequested({required this.bot, this.forceStart = false});

  final BotOpponent bot;
  final bool forceStart;

  @override
  List<Object?> get props => [bot];
}

final class ContinueMatchRequested extends BotSelectBlocEvent {
  const ContinueMatchRequested({required this.session});

  final GameSession session;

  @override
  List<Object?> get props => [session];
}

final class MatchStarted extends BotSelectBlocEvent {
  const MatchStarted();
}
