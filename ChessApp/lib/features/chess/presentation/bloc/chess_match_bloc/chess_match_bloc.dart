import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/extensions/board_side_extensions.dart';
import 'package:chess/features/chess/domain/extensions/game_session_extensions.dart';
import 'package:chess/features/chess/domain/extensions/move_extensions.dart';
import 'package:chess/features/chess/domain/models/fen.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_opponent_turn_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/make_move_usecase.dart';
import 'package:chess/features/chess/domain/usecases/match_result_evaluate_usecase.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/states.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class ChessMatchBloc extends Bloc<ChessMatchBlocEvent, ChessMatchBlocState> {
  ChessMatchBloc({
    required this.makeMoveUsecase,
    required this.sessions,
    required this.getAppUserUsecase,
    required this.bots,
    required this.getOpponentTurnUsecase,
    required this.matchResultEvaluateUseCase,
  }) : super(EmptyState()) {
    on<MoveRequested>(_onMoveRequestedHandle);
    on<LoadMatchRequested>(_onLoadMatchHandle);
    on<TurnChanged>(_onTurnChanged);
  }

  final MakeMoveUsecase makeMoveUsecase;
  final GetAppUserUsecase getAppUserUsecase;
  final ISessionRepository sessions;
  final IBotRepository bots;
  final GetOpponentTurnUsecase getOpponentTurnUsecase;
  final MatchResultEvaluateUseCase matchResultEvaluateUseCase;
  
  Future _onMoveRequestedHandle(MoveRequested event, Emitter<ChessMatchBlocState> emit) async {
    if(state is! MatchStateActive) return;

    final current = (state as MatchStateActive).state;

    // Pawn promotion case handle
    if(event.move.isPromotionPawnMove(current.position)){
      current.moveToPromote = event.move as NormalMove;
      emit(MatchStateActive(state: current));
      return;
    }

    // Chessground library, just tell me why...
    current.moveToPromote = null;

    var result = await makeMoveUsecase(MoveParams(move: event.move, position: current.position));

    result.when(
      success: (newPosition) async {
        final updatedState = current.withPosition(position: newPosition);
        emit(MatchStateActive(state: updatedState));

        // Persist session state to repository
        final session = await sessions.getById(current.relatedSessionId);
        final fen = Fen(value: newPosition.fen);
        final updatedSession = session.addInHistory(fen: fen);
        await sessions.update(updatedSession);
      },
      failure: (_) => emit(InternalError(error: "Error occured on move!")),
    );
  }

  Future _onLoadMatchHandle(LoadMatchRequested event, Emitter<ChessMatchBlocState> emit) async {
    try{
      
      var appUser = await getAppUserUsecase(NoParams());
      var session = await sessions.getById(event.sessionId);
      var userSide = session.getUserSide(appUser.value.id);
            
      var position = Chess.fromSetup(Setup.parseFen(session.history.lastOrNull?.value ?? Fen.initial.value));
      
      var state = MatchState(
        position: position,
        userSide: userSide,
        white: await _restoreOpponent(session.white),
        black: await _restoreOpponent(session.black),
        relatedSessionId: event.sessionId,
      );

      emit(MatchStateActive(state: state));
    }
    on Exception catch (e){
      emit(InternalError(error: e.toString()));
    }
  }

  Future<Opponent> _restoreOpponent(SessionOpponent opponent) async {
    if(opponent.type == OpponentType.bot) return bots.getById(opponent.id);

    if(opponent.type == OpponentType.player){
      var user = await getAppUserUsecase(NoParams());
      if(opponent.id == user.value.id) {return user.value;}
    }

    throw UnimplementedError();
  }

  Future<void> _onTurnChanged(TurnChanged event, Emitter<ChessMatchBlocState> emit) async {
    if (state is! MatchStateActive) return;
    final current = (state as MatchStateActive).state;

    if (current.position.isGameOver) {
      await _emitMatchOver(current, emit);
      return;
    }

    // If user turn do nothing
    if (current.userSide.isPlayerTurn(current.position.turn)) return;

    final turnTaker = current.getTurnTaker(current.position.turn);

    // Process opponent turn
    await getOpponentTurnUsecase
        // Get opponent move
        .call(opponent: turnTaker, position: current.position)
        .mapErrorAsync((e) => InternalError(error: e.message))
        // Apply move and get new position
        .bindAsync((move) async {
          return await makeMoveUsecase(
            MoveParams(move: move, position: current.position),
          ).mapErrorAsync((e) => InternalError(error: "Fail on opponent move!"));
        })
        // emit new board state to view
        .onSuccessAsync((newPosition) async {
          final updatedState = current.withPosition(position: newPosition);
          emit(MatchStateActive(state: updatedState));          
        })
        // persist updated position in repository
        .onSuccessAsync((newPosition) async {
          final session = await sessions.getById(current.relatedSessionId);
          final fen = Fen(value: newPosition.fen);
          final updatedSession = session.addInHistory(fen: fen);
          await sessions.update(updatedSession);
        })
        // If any error at the chain, emit internal error state
        .mapErrorAsync((e) => emit(e));
  }

  Future<void> _emitMatchOver(MatchState state, Emitter<ChessMatchBlocState> emit) async {
    final result = await matchResultEvaluateUseCase(state);

    // wait for smoother transition
    await Future.delayed(const Duration(milliseconds: 1000));

    result.when(
      success: (matchResult) => emit(MatchOverState(result: matchResult)),
      failure: (failure) => emit(InternalError(error: failure.message)),
    );
  }
}



