import 'package:flutter/material.dart';

class AlignWidget extends StatelessWidget {
  const AlignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Alignment以矩形的中心点作为坐标原点
        Container(
          height: 120.0,
          width: 120.0,
          color: Colors.blue.shade50,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FlutterLogo(size: 60,),
          ),
        ),
        SizedBox(height: 20.0,),
        Container(/*
          height: 120.0,
          width: 120.0,*/
          color: Colors.blue.shade50,
          child: Align(
            //align宽高是子组件的宽高乘2, 这里就是60*2=120
            widthFactor: 2,
            heightFactor: 2,
            alignment: Alignment.center,
            child: FlutterLogo(size: 60,),
          ),
        ),
        SizedBox(height: 20.0,),
        //FractionalOffset的坐标原点为矩形的左侧顶点
        Container(/*
          height: 120.0,
          width: 120.0,*/
          color: Colors.blue.shade50,
          child: Align(
            //align宽高是子组件的宽高乘2, 这里就是60*2=120
            widthFactor: 2,
            heightFactor: 2,
            alignment: FractionalOffset(0.5, 0.5),
            child: FlutterLogo(size: 60,),
          ),
        ),
      ],
    );
  }
}
