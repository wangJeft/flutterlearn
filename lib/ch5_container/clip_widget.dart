import 'package:flutter/material.dart';

class ClipWidget extends StatefulWidget {
  const ClipWidget({super.key});

  @override
  State<ClipWidget> createState() => _ClipWidgetState();
}

class _ClipWidgetState extends State<ClipWidget> {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/mc.png", width: 60.0);
    return Center(
        child: Column(
      children: [
        avatar,
        ClipOval(
          child: avatar,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: avatar,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              widthFactor: .5,
              child: avatar,
            ),
            Text("你好世界", style: TextStyle(color: Colors.green))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRect(
              //将溢出部分剪裁
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,
                child: avatar,
              ),
            ),
            Text("你好世界", style: TextStyle(color: Colors.green))
          ],
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.green),
          child: ClipRect(
            clipper: MyClipper(),
            child: avatar,
          ),
        )
      ],
    ));
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
