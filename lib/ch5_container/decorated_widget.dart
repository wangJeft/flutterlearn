import 'package:flutter/material.dart';

class DecoratedWidget extends StatelessWidget {
  const DecoratedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange.shade700],
              ),
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: Colors.red.shade700, width: 2.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}