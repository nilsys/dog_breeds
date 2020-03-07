import 'package:flutter/material.dart';
import 'package:prototype_cal/components/two_page_book_component.dart';
import 'package:prototype_cal/model/bookmark.dart';
import 'package:prototype_cal/routes/two_page_book_route.dart';

class TwoPageBookViewer extends StatelessWidget {
  static const routeName = 'twoPageBookRoute';

  final Bookmark bookmark;

  const TwoPageBookViewer({@required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return TwoPageBookComponent(
      bookmark: bookmark,
      onSectionPressed: (int i) => onSectionPressed(context, i, bookmark),
      onBackPressed: () => onBackPressed(context, bookmark),
      onForwardPressed: () => onForwardPressed(context, bookmark),
    );
  }

  void onSectionPressed(BuildContext context, int i, Bookmark bookmark) {
    Bookmark newBookmark = bookmark.copyWith(sectionIndex: i, pageIndex: 0);
    Navigator.push(context, TwoPageBookRoute(bookmark: newBookmark));
  }

  void onBackPressed(BuildContext context, Bookmark bookmark) {
    Bookmark newBookmark;
    if (bookmark.pageIndex <= 1) {
      newBookmark = bookmark;
    } else {
      newBookmark = bookmark.copyWith(pageIndex: bookmark.pageIndex - 2);
    }
    Navigator.push(context, TwoPageBookRoute(bookmark: newBookmark));
  }

  void onForwardPressed(BuildContext context, Bookmark bookmark) {
    Bookmark newBookmark;
    if (bookmark.pageIndex >= bookmark.pagesInSectionCount - 2) {
      newBookmark = bookmark;
    } else {
      newBookmark = bookmark.copyWith(pageIndex: bookmark.pageIndex + 2);
    }
    Navigator.push(context, TwoPageBookRoute(bookmark: newBookmark));
  }
}
