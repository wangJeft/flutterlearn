import 'package:flutter/material.dart';
import 'package:flutterlearn/ch3_basic_component/button_widget.dart';
import 'package:flutterlearn/ch3_basic_component/image_icon_widget.dart';
import 'package:flutterlearn/ch3_basic_component/progress_widget.dart';
import 'package:flutterlearn/ch3_basic_component/text_widget.dart';
import 'package:flutterlearn/ch5_container/container_widget.dart';
import 'package:flutterlearn/ch5_container/decorated_widget.dart';
import 'package:flutterlearn/ch5_container/fitted_box_widget.dart';
import 'package:flutterlearn/ch5_container/scaffold_widget.dart';
import 'package:flutterlearn/ch6_scroll/single_child_scrollview.dart';
import 'package:flutterlearn/ch6_scroll/tabbar_view_widget.dart';

import 'ch3_basic_component/switch_checkbox_widget.dart';
import 'ch3_basic_component/textfield_form_widget.dart';
import 'ch4_layout/AlignWidget.dart';
import 'ch4_layout/constraints_widget.dart';
import 'ch4_layout/flex_widget.dart';
import 'ch4_layout/layoutbuilder_afterlayout_widget.dart';
import 'ch4_layout/stack_positioned_widget.dart';
import 'ch4_layout/wrap_flow_widget.dart';
import 'ch5_container/clip_widget.dart';
import 'ch5_container/transform_widget.dart';
import 'ch6_scroll/animated_list_widget.dart';
import 'ch6_scroll/custom_scroll_view.dart';
import 'ch6_scroll/custom_sliver.dart';
import 'ch6_scroll/grid_view_widget.dart';
import 'ch6_scroll/listview.dart';
import 'ch6_scroll/nested_scrollview.dart';
import 'ch6_scroll/page_view_widget.dart';
import 'ch6_scroll/scroll_controller_widget.dart';
import 'ch6_scroll/scroller_child_cache.dart';
import 'ch7_function_widget/async_update_ui.dart';
import 'ch7_function_widget/color_theme.dart';
import 'ch7_function_widget/cross_widget_stat_share.dart';
import 'ch7_function_widget/inherited_widget.dart';
import 'ch7_function_widget/nav_back_intercept.dart';

void main() {
  runApp(const MyApp());
  // runApp(const StateLifecycleTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        // useMaterial3: true,
      ),
      // home: const CounterWidget(),
      // home: const TapBoxA(),
      // home: const ParentWidget(),
      home: const RelayWidget(),
    );
  }
}

class RelayWidget extends StatelessWidget {
  const RelayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Flutter Learn"),
      ),
      // body: const TextWidget(),
      // body: const ImageIconWidget(),
      // body: const ButtonWidget(),
      // body: const SwitchCheckBox(),
      // body: const TextFieldFormWidget(),
      // body: const ProgressWidget(),
      // body: const WidgetConstraints(),
      // body: const ExpandedWidget(),
      // body: const WrapFlowWidget(),
      // body: const StackPositioned(),
      // body: const AlignWidget(),
      // body: const LayoutBuilderAfterLayout(),
      // body: const DecoratedWidget(),
      // body: const TransformWidget(),
      // body: const ContainerWidget(),
      // body: const ClipWidget(),
      // body: const FittedBoxWidget(),
      // body: const SingleChildScrollViewWidget(),
      // body: const AnimatedListWidget(),
      // body: const GridViewWidget(),
      // body: const PageViewWidget(),
      // body: const PageViewCacheWidget(),
      // body: const CustomScrollViewWidget(),
      // body: const CustomSliverWidget(),
      // body: const NestedScrollViewWidget(),
      // body: const WillPopScopeWidget(),
      // body: const DataShareTestWidget(),
      // body: const ProviderRoute(),
      // body: const NavBarTest(),
      // body: const FutureBuilderWidget(),
      body: const StreamBuilderWidget(),
    );
    // return ScaffoldWidget();
    // return ScrollControllerWidget();
    // return TabBarViewWidget();
    // return SnapAppBar();
    // return NestedTabBarViewWidget();
  }
}
