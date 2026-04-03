import 'package:chess/di/injection.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/ui/screens/bot_select_screen.dart';
import 'package:chess/ui/screens/match_screen/match_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'go_router_builder.g.dart';

@TypedGoRoute<BotSelectScreenRoute>(path: '/bots')
@immutable
class BotSelectScreenRoute extends GoRouteData with $BotSelectScreenRoute{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<BotSelectBloc>(
      create: (BuildContext context) => getIt.get<BotSelectBloc>(),
      child: const BotSelectScreen(),
    );
  }
}

@TypedGoRoute<GameScreenRoute>(path: '/game/:sessionId')
@immutable
class GameScreenRoute extends GoRouteData with $GameScreenRoute {
  final String sessionId;
  const GameScreenRoute({required this.sessionId});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<ChessMatchBloc>(
        create: (BuildContext context) => getIt.get<ChessMatchBloc>(),
        child: MatchScreen(sessionId: SessionId.restore(uuid: sessionId)),
      );
}
