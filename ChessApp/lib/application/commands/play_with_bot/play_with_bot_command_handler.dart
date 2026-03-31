import 'package:chess/application/commands/play_with_bot/play_with_bot_command.dart';
import 'package:chess/application/state/application_storage.dart';
import 'package:chess/core/models/app_user.dart';
import 'package:chess/core/models/game_session/game_session.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chess/di/injection.dart';
import 'package:chess/persistence/sessions_repository.dart';
import 'package:chess/routing/go_router_builder.dart';
import 'package:chess/ui/widgets/error_popup.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class PlayWithBotCommandHandler
    implements ICommandHandler<PlayWithBotCommand, void> {

  const PlayWithBotCommandHandler(this.sessions);

  final ISessionRepository sessions;

  @override
  Future<void> handle(PlayWithBotCommand command) async {
    
    var user = getIt.get<ApplicationStorage>().user;
    
    user.map(
      onSome: (user) => _startGame(user.asOpponent(Side.white), command.bot, command.context), 
      onNone: () => showErrorPopup(command.context, "No user associated with current session!"));
  }
  
  void _startGame(Opponent player, Opponent bot, BuildContext context){
    var session = GameSession.create(white: player, black: bot, userSide: PlayerSide.white);
    sessions.add(session);
    
    GameScreenRoute(sessionId: session.sessionId.value).push(context);
  }
}
