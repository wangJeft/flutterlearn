import 'package:flutter/material.dart';

class StackPositioned extends StatelessWidget {
  const StackPositioned({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(left: 18.0, child: Text("I am Jack")),
          Container(
            color: Colors.red,
            child: Text(
              "Hello world",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(top: 18.0, child: Text("Your friend"))
        ],
      ),
    );
  }
}
