import 'package:flutter/material.dart';
import 'package:flutterlearn/ch7_function_widget/async_update_ui.dart';
import 'package:flutterlearn/common/common.dart';

import 'color_theme.dart';
import 'cross_widget_stat_share.dart';
import 'dialog_widget.dart';
import 'inherited_widget.dart';
import 'nav_back_intercept.dart';

class FunctionRoute extends StatelessWidget {
  const FunctionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "FutureBuilder", page: FutureBuilderWidget()),
        PagePair(name: "NavBarTest", page: NavBarTest()),
        PagePair(name: "ProviderRoute", page: ProviderRoute()),
        PagePair(name: "Dialog", page: DialogWidget()),
        PagePair(name: "DataShareTest", page: DataShareTestWidget()),
        PagePair(name: "WillPopScope", page: WillPopScopeWidget()),
      ],
      pageName: "功能型组件",
    );
  }
}
