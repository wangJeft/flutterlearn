import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterlearn/ch11_file_net_operate/file_net_route.dart';
import 'package:flutterlearn/ch13_localization/demo_local.dart';
import 'package:flutterlearn/ch3_basic_component/basic_component_route.dart';
import 'package:flutterlearn/ch3_basic_component/button_widget.dart';
import 'package:flutterlearn/ch3_basic_component/image_icon_widget.dart';
import 'package:flutterlearn/ch3_basic_component/progress_widget.dart';
import 'package:flutterlearn/ch3_basic_component/text_widget.dart';
import 'package:flutterlearn/ch4_layout/layout_route.dart';
import 'package:flutterlearn/ch5_container/container_route.dart';
import 'package:flutterlearn/ch5_container/container_widget.dart';
import 'package:flutterlearn/ch5_container/decorated_widget.dart';
import 'package:flutterlearn/ch5_container/fitted_box_widget.dart';
import 'package:flutterlearn/ch5_container/scaffold_widget.dart';
import 'package:flutterlearn/ch6_scroll/scroll_route.dart';
import 'package:flutterlearn/ch6_scroll/single_child_scrollview.dart';
import 'package:flutterlearn/ch6_scroll/tabbar_view_widget.dart';
import 'package:flutterlearn/ch7_function_widget/function_route.dart';
import 'package:flutterlearn/ch8_event_notify_process/gesture_detector.dart';
import 'package:flutterlearn/l10n/localization_intl.dart';

import 'ch10_custom_widget/custom_widget.dart';
import 'ch11_file_net_operate/dio.dart';
import 'ch11_file_net_operate/file_operate.dart';
import 'ch11_file_net_operate/http_client.dart';
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
import 'ch7_function_widget/dialog_widget.dart';
import 'ch7_function_widget/inherited_widget.dart';
import 'ch7_function_widget/nav_back_intercept.dart';
import 'ch8_event_notify_process/event_notification.dart';
import 'ch8_event_notify_process/original_event.dart';
import 'ch9_animation/animation_base_widget.dart';

void main() {
  runApp(MyApp());
  // runApp(const StateLifecycleTest());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = <String, WidgetBuilder>{
    "BasicComponent": (context) => BasicComponentRoute(),
    "Layout": (context) => LayoutRoute(),
    "Container": (context) => ContainerRoute(),
    "Scroll": (context) => ScrollRoute(),
    "Function": (context) => FunctionRoute(),
    "Animation": (context) => AnimationBaseWidget(),
    "CustomWidget": (context) => CustomWidget(),
    "FileNet": (context) => FileNetRoute(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //多语言支持
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // DemoLocalizationsDelegate()
        DemoLocalizationsDelegate2()
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CN'),
      ],
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        // useMaterial3: true,
      ),*/

      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
      ),
      // home: const CounterWidget(),
      // home: const TapBoxA(),
      // home: const ParentWidget(),
      home: RelayWidget(routes: routes),
      routes: routes,
    );
  }
}

class RelayWidget extends StatelessWidget {
  RelayWidget({
    required this.routes,
    super.key,
  });

  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        //title会跟着系统语言变化
        // title: Text(DemoLocalizations.of(context).title),
        title: Text(DemoLocalizations2.of(context).title),
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
      // body: const StreamBuilderWidget(),
      // body: const DialogWidget(),
      // body: const PointerMoveIndicator(),
      // body: const GestureWidget(),
      // body: const NotificationRoute(),
      // body: const AnimationBaseWidget(),
      // body: const CustomWidget(),
      // body: const FileOperate(),
      // body: const HttpTestRoute(),
      // body: const DioRoute(),
      body: ListView(
        children: routes.keys
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, e);
                    },
                    child: Text(e),
                  ),
                ))
            .toList(),
      ),
    );
    // return ScaffoldWidget();
    // return ScrollControllerWidget();
    // return TabBarViewWidget();
    // return SnapAppBar();
    // return NestedTabBarViewWidget();
  }
}
