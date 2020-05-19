import 'package:custom_cal/components/book/mobile_book.dart';
import 'package:custom_cal/components/book/web_book.dart';
import 'package:custom_cal/model/model.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class BookScreen extends StatelessWidget {
  final BookData book;

  const BookScreen({@required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //child: _buildPlatform(context),
        child: _buildMobile(context),
      ),
    );
  }

  Widget _buildPlatform(BuildContext context) {
    if (kIsWeb) {
      return _buildWeb(context);
    } else if (Platform.isAndroid) {
      return _buildMobile(context);
    } else {
      throw FallThroughError();
    }
  }

  Widget _buildWeb(BuildContext context) {
    return WebBook(
      startingBookmark: Bookmark.firstPage(book: book),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return MobileBook(
      startingBookmark: Bookmark.firstPage(book: book),
    );
  }
}
