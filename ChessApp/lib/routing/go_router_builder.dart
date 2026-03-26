import 'package:chess/core/models/game_session.dart';
import 'package:chess/ui/screens/bot_select_screen.dart';
import 'package:chess/ui/screens/game_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'go_router_builder.g.dart';

@TypedGoRoute<BotSelectScreenRoute>(path: '/bots')
@immutable
class BotSelectScreenRoute extends GoRouteData with $BotSelectScreenRoute{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BotSelectScreen();
  }
}

@TypedGoRoute<GameScreenRoute>(path: '/game/bot/:id')
@immutable
class GameScreenRoute extends GoRouteData with $GameScreenRoute {
  final int id;
  const GameScreenRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GameWithBotScreen(bot: BotDifficulty(level: id));
  }
}
