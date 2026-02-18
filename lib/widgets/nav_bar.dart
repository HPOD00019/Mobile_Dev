import 'package:flutter/material.dart';
import 'package:mobile_dev/providers/page_provider.dart';

class NavBar<T extends PagesProvider> extends StatelessWidget {
  const NavBar({
    required this.pagesProvider,
    super.key,
    this.backgroundColor = const Color.fromARGB(255, 172, 172, 172),
  });
  final PagesProvider pagesProvider;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: pagesProvider.getCurrentPageInex(),
      onDestinationSelected: (index) {
        pagesProvider.setPage(pagesProvider.getPageNameByIndex(index));
      },
      destinations: pagesProvider
          .getAwaiblePages()
          .map((page) => pagesProvider.getPageIconView(page))
          .toList(),
      height: 80,
      backgroundColor: backgroundColor,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    );
  }
}
