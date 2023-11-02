import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformWidget extends StatelessWidget {
  const TransformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: Text('Apartment for rent!'),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          SizedBox(height: 40.0),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Text("Hello world"),
            ),
          ),
          SizedBox(height: 40.0),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: Text("Hello world"),
            ),
          ),
          SizedBox(height: 40.0),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //RotatedBox和Transform不同, RotatedBox是作用于layout阶段，所以子组件会旋转90度(而不只是绘制的内容)
            child: RotatedBox(
              quarterTurns: 1,
              child: Text("Hello world"),
            ),
          ),
          Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),),
        ],
      ),
    );
  }
}
