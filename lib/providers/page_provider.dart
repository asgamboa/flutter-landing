import 'package:flutter/material.dart';

import 'package:universal_html/html.dart' as html;

class PageProvider extends ChangeNotifier {
  PageController scrollController = PageController();

  final List<String> _pages = const ["home", "about", "pricing", "contact", "location"];

  int _currentIndex = 0;

  void createScrollController(String routeName) {
    int pageIndex = _pages.contains(routeName) ? _pages.indexOf(routeName) : 0;

    scrollController = PageController(
      initialPage: pageIndex,
    );

    html.document.title = _pages[pageIndex];

    scrollController.addListener(() {
      final index = (scrollController.page ?? 0).round();

      if (index != _currentIndex) {
        html.window.history.pushState(null, "none", "#/${_pages[index]}");
        _currentIndex = index;
        html.document.title = _pages[_currentIndex];
      }
    });
  }

  void goTo(int index) {
    html.window.history.pushState(null, "none", "#/${_pages[index]}");

    scrollController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}
