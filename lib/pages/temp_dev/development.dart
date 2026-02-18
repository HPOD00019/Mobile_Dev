import 'package:flutter/material.dart';
import 'package:mobile_dev/providers/page_provider.dart';
import 'package:mobile_dev/widgets/nav_bar.dart';
import 'package:provider/provider.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PagesProvider<DevPage>>(context);
    return Scaffold(
      appBar: AppBar(title: Text("DevPage")),
      body: pageProvider.getCurrentPage(),
      bottomNavigationBar: NavBar(pagesProvider: pageProvider),
    );
  }
}
