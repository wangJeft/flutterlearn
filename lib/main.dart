import 'package:flutter/material.dart';
import 'package:flutterlearn/ch3_basic_component/button_widget.dart';
import 'package:flutterlearn/ch3_basic_component/image_icon_widget.dart';
import 'package:flutterlearn/ch3_basic_component/progress_widget.dart';
import 'package:flutterlearn/ch3_basic_component/text_widget.dart';
import 'package:flutterlearn/ch5_container/container_widget.dart';
import 'package:flutterlearn/ch5_container/decorated_widget.dart';
import 'package:flutterlearn/ch5_container/fitted_box_widget.dart';
import 'package:flutterlearn/ch5_container/scaffold_widget.dart';

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
    /*return Scaffold(
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
      body: const FittedBoxWidget(),
    );*/
    return ScaffoldWidget();
  }
}
