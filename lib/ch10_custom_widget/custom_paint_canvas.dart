import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //给棋盘加一个RepaintBoundary, 防止点击按钮时棋盘重绘
          RepaintBoundary(
              child: CustomPaint(
            size: Size(300, 300),
            painter: MyPainter(),
          )),
          ElevatedButton(onPressed: () {}, child: Text("刷新"))
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  static const int lintCount = 18;

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    var rect = Offset.zero & size;
    drawChessboard(canvas, rect);
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawChessboard(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;
    for (int i = 0; i <= lintCount; ++i) {
      double dy = rect.top + rect.height / lintCount * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= lintCount; ++i) {
      double dx = rect.left + rect.width / lintCount * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / lintCount;
    double eHeight = rect.height / lintCount;

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawCircle(Offset(rect.center.dx, rect.center.dy), 2, paint);

    canvas.drawCircle(Offset(rect.center.dx - eWidth, rect.center.dy),
        min(eWidth / 2, eHeight / 2) - 2, paint);

    paint.color = Colors.white;
    canvas.drawCircle(Offset(rect.center.dx + eWidth, rect.center.dy),
        min(eWidth / 2, eHeight / 2) - 2, paint);
  }
}