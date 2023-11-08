import 'package:flutter/material.dart';
import 'package:flutterlearn/ch6_scroll/scroller_child_cache.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({super.key});

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs
              .map((e) => KeepAliveWrapper(
                      child: Center(
                    child: Text(
                      e,
                      textScaleFactor: 5,
                    ),
                  )))
              .toList()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}