import 'package:flutter/material.dart';
import 'package:flutterlearn/ch10_custom_widget/custom_paint_canvas.dart';
import 'package:flutterlearn/ch10_custom_widget/gradient_button.dart';
import 'package:flutterlearn/ch10_custom_widget/gradient_circular_progress_indicator.dart';
import 'package:flutterlearn/ch10_custom_widget/turn_box.dart';

import 'custom_check_box.dart';
import 'custom_done_widget.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return GradientButtonRoute();
    // return TurnBoxRoute();
    // return CustomPaintRoute();
    // return GradientCircularProgressRoute();
    // return CustomCheckboxTest();
    return DoneWidgetRoute();
  }
}
