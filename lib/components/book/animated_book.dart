import 'dart:math';
import 'package:flutter/material.dart';

import '../layout/animated_oriented_layout.dart';
import '../animation/flip_direction.dart';
import '../../model/bookmark.dart';

/// Displays a book to the user.
class AnimatedBook extends StatefulWidget {
  final Bookmark startingBookmark;

  final Duration animationDuration = const Duration(milliseconds: 300);

  const AnimatedBook({
    @required this.startingBookmark,
  });

  @override
  State<StatefulWidget> createState() =>
      AnimatedBookState(bookmark: startingBookmark);
}

class AnimatedBookState extends State<AnimatedBook>
    with SingleTickerProviderStateMixin {
  Bookmark lastBookmark;
  Bookmark bookmark;

  AnimationController _controller;
  Animation _animation;

  AnimatedBookState({@required this.bookmark}) : lastBookmark = bookmark;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: pi).animate(_controller);

    // Rebuild when animation ends
    _controller.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOrientedLayout(
      lastBookmark: lastBookmark,
      bookmark: bookmark,
      flipDirection: _flipDirection,
      updateBookmark: _updateBookmark,
      controller: _controller,
      animation: _animation,
      hyperlinkFunction: _hyperlinkFunction,
    );
  }

  void _hyperlinkFunction(int page, int section) {
    print(section.toString() + page.toString());
    _updateBookmark(bookmark.changeSection(section).changePage(page));
  }

  void _updateBookmark(Bookmark newBookmark) {
    if (newBookmark.compareTo(bookmark) != 0) {
      setState(() {
        lastBookmark = bookmark;
        bookmark = newBookmark;
        _controller.forward(from: 0);
      });
    }
  }

  FlipDirection get _flipDirection {
    if (bookmark.compareTo(lastBookmark) >= 0) {
      return FlipDirection.left;
    } else {
      return FlipDirection.right;
    }
  }
}
