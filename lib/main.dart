import 'package:flutter/material.dart';
import 'package:mobile_dev/app.dart';
import 'package:mobile_dev/pages/temp_dev/development.dart';
import 'package:mobile_dev/pages/pages.dart';
import 'package:mobile_dev/providers/page_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PagesProvider<App>(
            startingPage: Pages.devPage,
            awaiblePages: [Pages.devPage],
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PagesProvider<DevPage>(
            startingPage: Pages.deskPage,
            awaiblePages: [
              Pages.artyom,
              Pages.maxim,
              Pages.misha,
              Pages.alexiy,
              Pages.deskPage,
            ],
          ),
        ),
      ], // <- global app providers.
      child: MaterialApp(home: Scaffold(body: App())),
    );
  }
}
