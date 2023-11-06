import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    for (int i = 0; i < 6; i++) {
      children.add(Page(text: 'page ${i + 1}'));
    }

    return PageView(
      //置为 true 时就只会缓存前后各一页
      allowImplicitScrolling: true,
      children: children,
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.text}');
    return Center(child: Text(widget.text, textScaleFactor: 5));
  }
}
