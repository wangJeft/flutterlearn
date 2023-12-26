import 'package:flutter/material.dart';
import 'package:flutterlearn/ch5_container/clip_widget.dart';
import 'package:flutterlearn/ch5_container/container_widget.dart';
import 'package:flutterlearn/ch5_container/decorated_widget.dart';
import 'package:flutterlearn/ch5_container/transform_widget.dart';
import 'package:flutterlearn/common/common.dart';

import 'fitted_box_widget.dart';

class ContainerRoute extends StatelessWidget {
  const ContainerRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "clip", page: ClipWidget()),
        PagePair(name: "container", page: ContainerWidget()),
        PagePair(name: "decorated", page: DecoratedWidget()),
        PagePair(name: "fittedbox", page: FittedBoxWidget()),
        PagePair(name: "Transform", page: TransformWidget()),
      ],
      pageName: "Container",
    );
  }
}
