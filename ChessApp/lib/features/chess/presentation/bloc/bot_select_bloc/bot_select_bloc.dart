import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/usecases/create_match_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/try_find_existing_match_usecase.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class BotSelectBloc extends Bloc<BotSelectBlocEvent, BotSelectBlocState> {
  BotSelectBloc({
    required this.botsRepository,
    required this.tryFindExistingMatchUseCase,
    required this.createMatchUseCase,
    required this.getAppUserUsecase,
  }) : super(const BotSelectInitial()) {
    debugPrint("BotSelectBloc initialized");
    on<BotOptionsRequested>(_onBotOptionsRequested);
    on<BotSelected>(_onBotSelected);
    on<MatchRequested>(_onMatchRequested);
    on<ConcedeAndStartNew>(_onConcedeAndStartNew);
    on<ReconnectToMatch>(_onReconnectToMatch);
    on<MatchStarted>(_onMatchStarted);
  }

  final IBotRepository botsRepository;
  final TryFindExistingMatchUseCase tryFindExistingMatchUseCase;
  final CreateMatchUseCase createMatchUseCase;
  final GetAppUserUsecase getAppUserUsecase;

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
    
    final result = await tryFindExistingMatchUseCase(event.bot);

    await result.when(
      success: (existingSession) async {
        if (state is BotsLoaded) {
          final currentState = state as BotsLoaded;
          emit(
            currentState.withExistingSession(
              session: existingSession,
              bot: event.bot,
            ),
          );
        }
      },
      failure: (failure) async {
        if (failure is NoActiveMatch) {
          await _createNewMatch(event.bot, emit);
        } else {
          emit(BotSelectError(message: failure.message));
        }
      },
    );
  }

  Future<void> _onConcedeAndStartNew(
    ConcedeAndStartNew event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    await _createNewMatch(event.bot, emit);
  }

  Future<void> _onReconnectToMatch(
    ReconnectToMatch event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    emit(MatchReady(sessionId: event.session.id));
  }

  Future<void> _createNewMatch(
    BotOpponent bot,
    Emitter<BotSelectBlocState> emit,
  ) async {
    final appUserResult = await getAppUserUsecase(NoParams());

    if (appUserResult is Failure<HumanOpponent, GetAppUserFailure>) {
      emit(BotSelectError(message: 'Failed to get current user'));
      return;
    }

    final appUser = appUserResult.value;

    final result = await createMatchUseCase(
      white: SessionOpponent(type: OpponentType.player, id: appUser.id),
      black: SessionOpponent(type: OpponentType.bot, id: bot.id),
    );

    result.when(
      success: (sessionId) => emit(MatchReady(sessionId: sessionId)),
      failure: (failure) => emit(BotSelectError(message: failure.message)),
    );
  }

  Future<void> _onMatchStarted(
    MatchStarted event,
    Emitter<BotSelectBlocState> emit,
  ) async {
    emit(BotSelectInitial());
  }
}
