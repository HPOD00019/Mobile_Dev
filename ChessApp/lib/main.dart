import 'package:chess/app.dart';
import 'package:chess/di/injection.dart';
import 'package:flutter/material.dart';

void main() {
  injectDependencies();
  runApp(
    const MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChessApp();
  }
}
