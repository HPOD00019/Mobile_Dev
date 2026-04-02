import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/start_match_usecase.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class BotSelectBloc extends Bloc<BotSelectBlocEvent, BotSelectBlocState> {
  BotSelectBloc({
    required this.botsRepository,
    required this.sessionsRepository,
    required this.getAppUserUsecase,
    required this.startMatchUseCase,
  }) : super(const BotSelectInitial()) {
    debugPrint("BotSelectBloc initialized");
    on<BotOptionsRequested>(_onBotOptionsRequested);
    on<BotSelected>(_onBotSelected);
    on<MatchRequested>(_onMatchRequested);
    on<ContinueMatchRequested>(_onContinueMatchRequested);
    on<MatchStarted>(_onMatchStarted);
  }

  final IBotRepository botsRepository;
  final ISessionRepository sessionsRepository;
  final GetAppUserUsecase getAppUserUsecase;
  final StartMatchUseCase startMatchUseCase;

  Future<void> _onBotOptionsRequested(
    BotOptionsRequested event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    emit(const BotsLoading());
    try {
      final bots = await botsRepository.getAll();

      final sortedBots = bots.toList();
      sortedBots.sort((a, b) => a.difficulty.compareTo(b.difficulty));

      emit(BotsLoaded(bots: sortedBots.toSet(), selectedBot: sortedBots.first));
    } catch (e) {
      emit(BotSelectError(message: 'Failed to load bots: $e'));
    }
  }

  Future<void> _onBotSelected(
    BotSelected event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    if (state is BotsLoaded) {
      final currentState = state as BotsLoaded;
      emit(BotsLoaded(bots: currentState.bots, selectedBot: event.bot));
    }
  }

  Future<void> _onMatchRequested(
    MatchRequested event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    final result = await startMatchUseCase(event.bot, forceCreate: event.forceStart);

    result.when(
      success: (match) {
        if (match.alreadyExist) {
          if (state is BotsLoaded) {
            final currentState = state as BotsLoaded;
            emit(BotsLoaded(
              bots: currentState.bots,
              selectedBot: currentState.selectedBot,
              pendingSession: PendingMatchAction(
                existingSession: match.existingSession!,
                bot: event.bot,
              ),
            ));
          }
        } else {
          emit(MatchReady(sessionId: match.newSessionId!));
        }
      },
      failure: (failure) => emit(BotSelectError(message: failure.message)),
    );
  }

  Future<void> _onContinueMatchRequested(
    ContinueMatchRequested event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    emit(MatchReady(sessionId: event.session.id));
  }

  Future<void> _onMatchStarted(
    MatchStarted event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    emit(BotSelectInitial());
  }
}
