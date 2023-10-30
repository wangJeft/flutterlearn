import 'package:flutter/material.dart';

class MyIcons {
  static const IconData qq =
      IconData(0xe6da, fontFamily: 'MyIconFont', matchTextDirection: true);
  static const IconData wechat =
      IconData(0xe6b4, fontFamily: 'MyIconFont', matchTextDirection: true);
  static const IconData phone =
      IconData(0xe605, fontFamily: 'MyIconFont', matchTextDirection: true);
}

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image(image: AssetImage("images/bg_4.png")),
          SizedBox(height: 10.0),
          Image.asset("images/bg_4.png"),
          SizedBox(height: 10.0),
          Image.network(
            "https://book.flutterchina.club/assets/img/logo.png",
            width: 100,
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.accessible, color: Colors.green),
              Icon(Icons.error, color: Colors.green),
              Icon(Icons.fingerprint_rounded, color: Colors.green)
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MyIcons.qq, color: Colors.blue),
              Icon(MyIcons.wechat, color: Colors.green),
              Icon(MyIcons.phone, color: Colors.purple)
            ],
          )
        ],
      ),
    );
  }
}
