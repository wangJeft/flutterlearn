import 'package:flutter/material.dart';
import 'package:flutterlearn/ch10_custom_widget/custom_check_box.dart';

class DoneWidget extends LeafRenderObjectWidget {
  final double strokeWidth;
  final Color color;
  final bool outline;

  DoneWidget(
      {this.strokeWidth = 2.0,
      this.color = Colors.green,
      this.outline = false,
      super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderDoneObject(strokeWidth, color, outline)
      ..animationStatus = AnimationStatus.forward; // 创建时执行正向动画
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderDoneObject renderObject) {
    renderObject
      ..strokeWidth = strokeWidth
      ..outline = outline
      ..color = color;
  }
}

class RenderDoneObject extends RenderBox with RenderObjectAnimationMixin {
  double strokeWidth;
  Color color;
  bool outline;
  ValueChanged<bool>? onChanged;

  RenderDoneObject(
    this.strokeWidth,
    this.color,
    this.outline,
  );

  @override
  Duration get duration => const Duration(milliseconds: 5000);

  @override
  void performLayout() {
    size = constraints
        .constrain(constraints.isTight ? Size.infinite : const Size(25, 25));
  }

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Curve curve = Curves.easeIn;
    final _progress = curve.transform(progress);
    Rect rect = offset & size;
    final paint = Paint()
      ..isAntiAlias = true
      ..style = outline ? PaintingStyle.stroke : PaintingStyle.fill
      ..color = color;
    if (outline) {
      paint.strokeWidth = strokeWidth;
      rect = rect.deflate(strokeWidth / 2);
    }

    context.canvas.drawCircle(rect.center, rect.shortestSide / 2, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = outline ? color : Colors.white
      ..strokeWidth = strokeWidth;

    final path = Path();
    Offset firstOffset =
        Offset(rect.left + rect.width / 6, rect.top + rect.height / 2.1);
    final secondOffset =
        Offset(rect.left + rect.width / 2.5, rect.bottom - rect.height / 3.3);
    path.moveTo(firstOffset.dx, firstOffset.dy);
    const adjustProgress = .6;
    if (_progress < adjustProgress) {
      //第一个点到第二个点的连线做动画(第二个点不停的变)
      Offset _secondOffset =
          Offset.lerp(firstOffset, secondOffset, _progress / adjustProgress)!;
      path.lineTo(_secondOffset.dx, _secondOffset.dy);
    } else {
      //链接第一个点和第二个点
      path.lineTo(secondOffset.dx, secondOffset.dy);
      //第三个点位置随着动画变，做动画
      final lastOffset =
          Offset(rect.right - rect.width / 5, rect.top + rect.height / 3.5);
      Offset _lastOffset = Offset.lerp(secondOffset, lastOffset,
          (progress - adjustProgress) / (1 - adjustProgress))!;
      path.lineTo(_lastOffset.dx, _lastOffset.dy);
    }
    context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }
}

class DoneWidgetRoute extends StatefulWidget {
  const DoneWidgetRoute({super.key});

  @override
  State<DoneWidgetRoute> createState() => _DoneWidgetRouteState();
}

class _DoneWidgetRouteState extends State<DoneWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DoneWidget(),
          DoneWidget(outline: true),
        ],
      ),
    );
  }
}
