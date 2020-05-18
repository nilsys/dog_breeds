import 'package:custom_cal/components/section_controller/list_section_controller.dart';
import 'package:flutter/material.dart';

import '../control_layer/button_control_layer.dart';
import '../control_layer/keyboard_control_layer.dart';
import '../../model/bookmark.dart';

class PortraitLayout extends StatelessWidget {
  final Bookmark bookmark;
  final Function(Bookmark) updateBookmark;
  final Function(int, int) hyperlinkFunction;
  final Widget spread;

  const PortraitLayout({
    @required this.bookmark,
    @required this.updateBookmark,
    @required this.hyperlinkFunction,
    @required this.spread,
  });

  bool get _backEnabled => bookmark.pageBeforeExists(1);
  Function get _onBackPressed => () => updateBookmark(bookmark.pageBefore(1));
  bool get _forwardEnabled => bookmark.pageAfterExists(1);
  Function get _onForwardPressed => () => updateBookmark(bookmark.pageAfter(1));

  Widget get sectionController {
    return ListSectionController(
      activeSection: bookmark.sectionIndex,
      onSectionPressed: (section) =>
          updateBookmark(bookmark.changeSection(section)),
      sections: bookmark.sections,
    );
  }

  List<Widget> get controlLayer {
    return [
      KeyboardControlLayer(
        backEnabled: _backEnabled,
        onBackPressed: _onBackPressed,
        forwardEnabled: _forwardEnabled,
        onForwardPressed: _onForwardPressed,
      ),
      ButtonControlLayer(
        backEnabled: _backEnabled,
        onBackPressed: _onBackPressed,
        forwardEnabled: _forwardEnabled,
        onForwardPressed: _onForwardPressed,
      ),
      /*
      SwipeControlLayer(
        backEnabled: _backEnabled,
        onBackPressed: _onBackPressed,
        forwardEnabled: _forwardEnabled,
        onForwardPressed: _onForwardPressed,
      ),
      */
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              -3, // horizontal, move right 10
              3, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Column(
        children: [
          sectionController,
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [spread, ...controlLayer],
            ),
          ),
        ],
      ),
    );
  }
}
