import 'package:chess/app.dart';
import 'package:chess/di/injection.dart';
import 'package:chess/http/configure_dio.dart';
import 'package:flutter/material.dart';

void main() {
  injectDependencies();
  configureDio();
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
