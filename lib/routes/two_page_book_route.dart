import 'package:flutter/material.dart';
import 'package:prototype_cal/components/two_page_book_viewer.dart';
import 'package:prototype_cal/model/bookmark.dart';

class TwoPageBookRoute extends PageRouteBuilder {
  final Bookmark bookmark;

  TwoPageBookRoute({@required this.bookmark})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              TwoPageBookViewer(bookmark: bookmark),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}