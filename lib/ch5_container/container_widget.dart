import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.0, left: 120.0),
          constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.red, Colors.orange],
                center: Alignment.center,
                radius: .98),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ],
          ),
          transform: Matrix4.rotationZ(.2),
          alignment: Alignment.center,
          child: Text(
            "5.20",
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        )
      ],
    );
  }
}
