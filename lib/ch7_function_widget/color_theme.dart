import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色

  const NavBar({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3),
      ]),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}

class NavBarTest extends StatelessWidget {
  const NavBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(color: Colors.blue, title: "title"),
        NavBar(color: Colors.white, title: "title")
      ],
    );
  }
}
