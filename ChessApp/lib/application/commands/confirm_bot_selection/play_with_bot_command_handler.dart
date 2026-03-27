import 'package:chess/application/commands/confirm_bot_selection/play_with_bot_command.dart';
import 'package:chess/application/state/opponent_provider.dart';
import 'package:chess/routing/go_router_builder.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class PlayWithBotCommandHandler
    implements ICommandHandler<PlayWithBotCommand, void> {

  const PlayWithBotCommandHandler(this._opponent);

  final IOpponentProvider _opponent;

  @override
  Future<void> handle(PlayWithBotCommand command) {
    _opponent.setOpponent(command.bot);

    GameScreenRoute(id: command.bot.difficulty.level).push(command.context);
    return Future.value();
  }
}
