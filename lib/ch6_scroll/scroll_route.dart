import 'package:flutter/material.dart';
import 'package:flutterlearn/ch6_scroll/animated_list_widget.dart';
import 'package:flutterlearn/ch6_scroll/grid_view_widget.dart';
import 'package:flutterlearn/common/common.dart';

import 'custom_scroll_view.dart';
import 'custom_sliver.dart';
import 'listview.dart';
import 'nested_scrollview.dart';
import 'scroll_controller_widget.dart';

class ScrollRoute extends StatelessWidget {
  const ScrollRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "AnimatedList", page: AnimatedListWidget()),
        PagePair(name: "CustomScrollView", page: CustomScrollViewWidget()),
        PagePair(name: "CustomSliver", page: CustomSliverWidget()),
        PagePair(name: "GridView", page: GridViewWidget()),
        PagePair(name: "ListView", page: ListViewWidget()),
        PagePair(name: "Nested", page: NestedScrollViewWidget()),
        PagePair(name: "ScrollControllerWidget", page: ScrollControllerWidget()),
      ],
      pageName: "ScrollPage",
    );
  }
}
