import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "hello world",
            textAlign: TextAlign.left,
          ),
          Text(
            "Hello world! I'm Jeft." * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            "Hello world",
            textScaleFactor: 1.5,
          ),
          Text(
            "Hello world",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: "Courier",
                background: Paint()..color = Colors.yellowAccent,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          const Text.rich(
            TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                  text: "https://flutter.cn/",
                  style: TextStyle(color: Colors.blue))
            ]),
          ),
          //Widget树的某个节点设置默认样式, 则该节点子树中的所有文本都默认使用这个样式
          const DefaultTextStyle(
            style: TextStyle(color: Colors.red, fontSize: 20.0),
            textAlign: TextAlign.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello world"),
                Text("I'm jeft"),
                Text(
                  "I'm Jeft",
                  style: TextStyle(inherit: false, color: Colors.grey),
                )
              ],
            ),
          ),
          const Text(
            "Use the font for this text",
            style: TextStyle(
              fontFamily: 'AlumniSansCollegiateOne',
              fontSize: 30.0
            ),
          )
        ],
      ),
    );
  }
}
