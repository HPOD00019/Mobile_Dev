import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:equatable/equatable.dart';

abstract class BotSelectBlocState extends Equatable {
  const BotSelectBlocState();

  @override
  List<Object?> get props => [];
}

final class BotSelectInitial extends BotSelectBlocState {
  const BotSelectInitial();
}

final class BotsLoading extends BotSelectBlocState {
  const BotsLoading();
}

final class BotsLoaded extends BotSelectBlocState {
  const BotsLoaded({
    required this.bots,
    required this.selectedBot,
    this.pendingSession,
  });

  final Set<BotOpponent> bots;
  final BotOpponent selectedBot;
  final PendingMatchAction? pendingSession;

  BotsLoaded withExistingSession({
    required GameSession session,
    required BotOpponent bot,
  }) => _with(
    pendingSession: PendingMatchAction(existingSession: session, bot: bot),
  );

  BotsLoaded _with({
    BotOpponent? selectedBot,
    required PendingMatchAction? pendingSession,
  }) => BotsLoaded(
    bots: bots,
    selectedBot: selectedBot ?? this.selectedBot,
    pendingSession: pendingSession,
  );

  @override
  List<Object?> get props => [bots, selectedBot, pendingSession];
}

final class PendingMatchAction {
  const PendingMatchAction({
    required this.existingSession,
    required this.bot,
  });

  final GameSession existingSession;
  final BotOpponent bot;
}

final class MatchReady extends BotSelectBlocState {
  const MatchReady({required this.sessionId});

  final SessionId sessionId;

  @override
  List<Object?> get props => [sessionId];
}

final class BotSelectError extends BotSelectBlocState {
  const BotSelectError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
