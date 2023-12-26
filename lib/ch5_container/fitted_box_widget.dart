import 'package:flutter/material.dart';

class FittedBoxWidget extends StatefulWidget {
  const FittedBoxWidget({super.key});

  @override
  State<FittedBoxWidget> createState() => _FittedBoxWidgetState();
}

class _FittedBoxWidgetState extends State<FittedBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          /*Row(
            //字符过长会溢出
            children: [
              Text(('hello' * 30)),
            ],
          ),
          Divider(
            height: 20.0,
            color: Colors.grey,
          ),

          wContainer(BoxFit.none),
          Text(('Wendux')),
          wContainer(BoxFit.contain), //按照子组件的比例缩放,尽可能多的占据父组件空间
          Text("Flutter中国"),
          SizedBox(
            height: 10,
          ),*/
          wRow(' 90000000000000000 '),
          FittedBox(child: wRow(' 90000000000000000 ')),
          wRow(' 800 '),
          FittedBox(child: wRow(' 800 ')),
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: e,
                ))
            .toList(),
      ),
    );
  }

  Widget wContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        // 子容器超过父容器大小
        child: Container(
          width: 60,
          height: 70,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget wRow(String text) {
    Widget child = Text(text);
    child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );
    return child;
  }
}
