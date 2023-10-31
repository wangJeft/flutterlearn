//尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio 等，

import 'package:flutter/material.dart';

class WidgetConstraints extends StatefulWidget {
  const WidgetConstraints({super.key});

  @override
  State<WidgetConstraints> createState() => _WidgetConstraintsState();
}

class _WidgetConstraintsState extends State<WidgetConstraints> {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: double.infinity, minHeight: 50.0),
            child: Container(
              height: 5.0, //虽然设置了5, 但最终会是50, 因为父组件ConstrainedBox做了限制
              child: redBox,
            ),
          ),

          SizedBox(
            height: 30,
          ),

          SizedBox(
            width: 80,
            height: 80,
            child: redBox,
          ),
          //上面的代码等效于下面的代码
          /*ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
            child: redBox,
          )*/
          SizedBox(
            height: 30,
          ),

          //多重限制下对于minWidth和minHeight来说，是取父子中相应数值较大的
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: redBox,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
              child: redBox,
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //UnconstrainedBox去除父组件的约束
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
            child: UnconstrainedBox(
                child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: redBox,
            )),
          ),
        ],
      ),
    );
  }
}
