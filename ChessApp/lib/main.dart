import 'package:chess/app.dart';
import 'package:chess/application/commands/make_move/make_move_command.dart';
import 'package:chess/application/commands/make_move/make_move_command_handler.dart';
import 'package:chess/application/commands/play_with_bot/play_with_bot_command.dart';
import 'package:chess/application/commands/play_with_bot/play_with_bot_command_handler.dart';
import 'package:chess/application/queries/get_bot_by_difficulty/get_bot_by_difficulty_query.dart';
import 'package:chess/application/queries/get_bot_by_difficulty/get_bot_by_difficulty_query_handler.dart';
import 'package:chess/application/queries/get_bots/get_bots_query.dart';
import 'package:chess/application/queries/get_bots/get_bots_query_handler.dart';
import 'package:chess/application/queries/get_session/get_session_by_id_queary.dart';
import 'package:chess/application/queries/get_session/get_session_by_id_queary_handler.dart';
import 'package:chess/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';

void main() {
  injectDependencies();
  runApp(
    MediatorConfig(
      queryHandlers: {
        GetSessionByIdQueary: () => getIt.get<GetSessionQuearyHandler>(),
        GetBotsQuery: () => getIt.get<GetBotsQueryHandler>(),
        GetBotByDifficultyQuery: () =>
            getIt.get<GetBotByDifficultyQueryHandler>()
      },
      commandHandlers: {
        PlayWithBotCommand: () => getIt.get<PlayWithBotCommandHandler>(),
        MakeMoveCommand: () => getIt.get<MakeMoveCommandHandler>()
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
