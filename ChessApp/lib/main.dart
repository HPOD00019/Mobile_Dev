import 'package:chess/app.dart';
import 'package:chess/application/commands/confirm_bot_selection/play_with_bot_command.dart';
import 'package:chess/application/commands/confirm_bot_selection/play_with_bot_command_handler.dart';
import 'package:chess/application/queries/get_bots/get_bots_query.dart';
import 'package:chess/application/queries/get_bots/get_bots_query_handler.dart';
import 'package:chess/application/queries/get_opponent/get_opponent_query.dart';
import 'package:chess/application/queries/get_opponent/get_opponent_query_handler.dart';
import 'package:chess/application/queries/get_session/get_session_queary.dart';
import 'package:chess/application/queries/get_session/get_session_queary_handler.dart';
import 'package:chess/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';

void main() {
  injectDependencies();
  runApp(
    MediatorConfig(
      queryHandlers: {
        GetSessionQueary: () => getIt.get<GetSessionQuearyHandler>(),
        GetOpponentQuery: () => getIt.get<GetOpponentQueryHandler>(),
        GetBotsQuery: () => getIt.get<GetBotsQueryHandler>()
      },
      commandHandlers: {
        PlayWithBotCommand: () => getIt.get<PlayWithBotCommandHandler>(),
      },
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChessApp();
  }
}
