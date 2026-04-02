import 'package:chess/routing/app_router.dart';
import 'package:flutter/material.dart';

final class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      builder: (context, child) =>
          Scaffold(body: child ?? const SizedBox.shrink()),
    );
  }
}
