import 'package:flutter/material.dart';
import 'package:flutterlearn/common/common.dart';

import 'constraints_widget.dart';
import 'AlignWidget.dart';
import 'flex_widget.dart';
import 'layoutbuilder_afterlayout_widget.dart';
import 'stack_positioned_widget.dart';
import 'wrap_flow_widget.dart';

class LayoutRoute extends StatelessWidget {
  const LayoutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "AlignWidget", page: AlignWidget()),
        PagePair(name: "constraints", page: WidgetConstraints()),
        PagePair(name: "AlignWidget", page: ExpandedWidget()),
        PagePair(name: "LayoutBuilder", page: LayoutBuilderAfterLayout()),
        PagePair(name: "StackPositioned", page: StackPositioned()),
        PagePair(name: "wrap_flow", page: WrapFlowWidget()),
      ],
      pageName: "LayoutRoute",
    );
  }
}
