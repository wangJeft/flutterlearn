import 'package:flutter/material.dart';
import 'progress_widget.dart';
import 'switch_checkbox_widget.dart';
import 'text_widget.dart';
import 'textfield_form_widget.dart';
import 'package:flutterlearn/common/common.dart';

import 'button_widget.dart';
import 'image_icon_widget.dart';

class BasicComponentRoute extends StatelessWidget {
  const BasicComponentRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "button", page: ButtonWidget()),
        PagePair(name: "image_icon", page: ImageIconWidget()),
        PagePair(name: "progress", page: ProgressWidget()),
        PagePair(name: "switch_check", page: SwitchCheckBox()),
        PagePair(name: "TextWidget", page: TextWidget()),
        PagePair(name: "textfield_form", page: TextFieldFormWidget()),
      ],
      pageName: "BasicComponent",
    );
  }
}
