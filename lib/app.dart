import 'package:flutter/material.dart';
import 'package:mobile_dev/providers/page_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PagesProvider<App>>(context);
    return pageProvider.getCurrentPage();
  }
}
