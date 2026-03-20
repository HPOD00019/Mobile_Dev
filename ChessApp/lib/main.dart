import 'package:chess/app.dart';
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
      },
      commandHandlers: {},
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
