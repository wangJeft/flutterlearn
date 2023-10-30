import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: [
            //value为null时则指示器会执行一个循环动画（模糊进度）
            LinearProgressIndicator(
              backgroundColor: Colors.red[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),

            SizedBox(height: 20),
            //当value不为null时，指示器为一个具体进度的进度条, 没有动画
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
            SizedBox(height: 20),

            CircularProgressIndicator(
              backgroundColor: Colors.red[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeCap: StrokeCap.round,
              strokeWidth: 10,
            ),

            SizedBox(height: 20),

            //当value不为null时，指示器为一个具体进度的进度条, 没有动画
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
            SizedBox(height: 20),

            //自定义大小使用sizeBox
            SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                backgroundColor: Colors.red[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.red[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),

            SizedBox(height: 20),

            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey,end: Colors.blue).animate(_animationController),
              value: _animationController.value,
            )
          ],
        ),
      ),
    );
  }
}
