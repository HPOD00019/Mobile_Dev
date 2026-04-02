import 'dart:async';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/extensions/game_session_extensions.dart';
import 'package:chess/features/chess/domain/extensions/move_extensions.dart';
import 'package:chess/features/chess/domain/models/fen.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/make_move_usecase.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/states.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class ChessMatchBloc extends Bloc<ChessMatchBlocEvent, ChessMatchBlocState> {
  ChessMatchBloc({
    required this.makeMoveUsecase, 
    required this.sessions, 
    required this.getAppUserUsecase, 
    required this.bots}) : super(EmptyState()){
    on<MoveRequested>(_onMoveRequstedHandle);
    on<LoadMatchRequested>(_onLoadMatchHandle);
  }
  
  final MakeMoveUsecase makeMoveUsecase;
  final GetAppUserUsecase getAppUserUsecase;
  final ISessionRepository sessions;
  final IBotRepository bots;
  
  Future _onMoveRequstedHandle(MoveRequested event, Emitter<ChessMatchBlocState> emit) async {
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
      success: (newPosition) {
        emit(MatchStateActive(state: current.withPosition(position: newPosition)));
      },
      failure: (_) => emit(InternalError(error: "Error occured on move!")),
    );
  }

  Future _onLoadMatchHandle(LoadMatchRequested event, Emitter<ChessMatchBlocState> emit) async {
    try{
      
      var appUser = await getAppUserUsecase(NoParams());
      var session = await sessions.getById(event.sessionId);
      var userSide = session.getUserSide(appUser.value.id);
      
      debugPrint("${userSide}");
      
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
}



