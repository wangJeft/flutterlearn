import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterlearn/ch10_custom_widget/turn_box.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    super.key,
    this.strokeWidth = 2.0,
    required this.radius,
    this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    required this.value,
  });

  //粗细
  final double strokeWidth;

  //圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  //进度值
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color>? colors;

  /// 渐变色的终止点，对应colors属性
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound) {
      // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
      // 下面调整的角度的计算公式是通过数学几何知识得出
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }

    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            total: totalAngle,
            radius: radius,
            colors: _colors,
            value: value),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth = 10.0,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      required this.radius,
      this.total = 2 * pi,
      required this.colors,
      this.stops,
      required this.value});

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }

    double _offset = strokeWidth / 2.0;
    double _value = value;
    //将value设置为0到1之间最接近的值
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              startAngle: 0.0, endAngle: _value, colors: colors, stops: stops)
          .createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({super.key});

  @override
  State<GradientCircularProgressRoute> createState() =>
      _GradientCircularProgressRouteState();
}

class _GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: [
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: [Colors.blue, Colors.blue],
                            strokeWidth: 3.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: [Colors.red, Colors.orange],
                            strokeWidth: 3.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            value: _animationController.value,
                            colors: [Colors.red, Colors.orange, Colors.red],
                            strokeWidth: 5.0,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.decelerate)
                                .value,
                            colors: [Colors.red, Colors.orange, Colors.red],
                            strokeWidth: 5.0,
                          ),
                          TurnBox(
                              turns: 1 / 8,
                              child: GradientCircularProgressIndicator(
                                radius: 50.0,
                                strokeCapRound: true,
                                value: CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.ease)
                                    .value,
                                colors: [Colors.red, Colors.orange, Colors.red],
                                totalAngle: 1.5 * pi,
                                strokeWidth: 5.0,
                              )),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              radius: 50.0,
                              strokeWidth: 3.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.transparent,
                              value: _animationController.value,
                            ),
                          ),
                          GradientCircularProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green.shade200,
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          )
                        ],
                      ),

                      GradientCircularProgressIndicator(
                        colors: [Colors.blue.shade700, Colors.blue.shade200],
                        radius: 100.0,
                        strokeWidth: 20.0,
                        value: _animationController.value,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GradientCircularProgressIndicator(
                          colors: [Colors.blue.shade700, Colors.blue.shade300],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          value: _animationController.value,
                          strokeCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              //width: 100.0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan.shade500],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan.shade500],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${(_animationController.value * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
