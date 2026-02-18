import 'package:flutter/material.dart' hide Page;
import 'package:mobile_dev/pages/pages.dart';

/// Provides page widgets for some target (which is defined by generic parameter T.)
class PagesProvider<T> with ChangeNotifier {
  PagesProvider({required Pages startingPage, required List<Pages> awaiblePages})
    : assert(
        awaiblePages.contains(startingPage),
        "PagesProvider: Cannot start from $startingPage page. Not exist in allowed pages.",
      ),
      _currentPage = startingPage,
      _awaiblePages = awaiblePages;

  final List<Pages> _awaiblePages;

  Pages _currentPage;

  void addPage(Pages value) {
    _awaiblePages.add(value);
    notifyListeners();
  }

  void removePage(Pages value) {
    _awaiblePages.remove(value);
    notifyListeners();
  }

  void setPage(Pages value) {
    assert(
      _awaiblePages.contains(value),
      "PageProvider: don't have access to $value page.",
    );
    _currentPage = value;
    notifyListeners();
  }

  Iterable<Pages> getAwaiblePages() => _awaiblePages;

  Widget getPageIconView(Pages page) => iconViews[page] ?? Icon(Icons.error);

  int getCurrentPageInex() => _awaiblePages.indexOf(_currentPage);
  Widget getCurrentPage() =>
      pages[_currentPage] ?? Center(child: Text("404 Not Found!"));

  Widget getPageByIndex(int index) {
    assert(
      _awaiblePages.length > index,
      "PageProvider: page index is out of range.",
    );
    return pages[_awaiblePages.elementAt(index)] ??
        Center(child: Text("404 Not Found!"));
  }

  int getPageIndexByName(Pages name) => _awaiblePages.indexOf(name);
  Pages getPageNameByIndex(int index) => _awaiblePages.elementAt(index);
}
