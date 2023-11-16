import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GestureWidget extends StatelessWidget {
  const GestureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return GestureDetectorTest();
    // return GestureRecognizerTest();
    return PointerDownListenerTest();
  }
}

class GestureDetectorTest extends StatefulWidget {
  const GestureDetectorTest({super.key});

  @override
  State<GestureDetectorTest> createState() => _GestureDetectorTestState();
}

class _GestureDetectorTestState extends State<GestureDetectorTest> {
  String _operation = "No Gesture detected";
  double _top = 0.0;
  double _left = 0.0;
  double _width = 120.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200,
              height: 100,
              child: Text(
                _operation,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => updateText("Tap"), //点击
            onDoubleTap: () => updateText("DoubleTap"), //双击
            onLongPress: () => updateText("LongPress"), //长按
          ),
        ),
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print(e.velocity);
              },
              //单一方向拖动只要监听下面即可, 水平方向也是一样
              /*onVerticalDragUpdate: (DragUpdateDetails details){
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (details){
                setState(() {
                  _left += details.delta.dx;
                });
              },*/
            )),
        Positioned(
            top: 18,
            child: GestureDetector(
              child: Image.asset(
                "images/weather.png",
                width: _width,
                fit: BoxFit.fill,
              ),
              onScaleUpdate: (details) {
                setState(() {
                  _width = 120 * details.scale.clamp(.1, 10.0);
                });
              },
            ))
      ],
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class GestureRecognizerTest extends StatefulWidget {
  const GestureRecognizerTest({super.key});

  @override
  State<GestureRecognizerTest> createState() => _GestureRecognizerTestState();
}

class _GestureRecognizerTestState extends State<GestureRecognizerTest> {
  //一种手势的识别器对应一个GestureRecognizer的子类，下面是点击的GestureRecognizer
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "hello world"),
        TextSpan(
            text: "点我变色",
            style: TextStyle(
                fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }),
        TextSpan(text: "hello world"),
      ])),
    );
  }
}

//可以监听PointerDownEvent事件的组件
class PointerDownListenerTest extends StatelessWidget {
  const PointerDownListenerTest({super.key});

  @override
  Widget build(BuildContext context) {
    return PointerDownListener(
      onPointerDown: (e) => print('down'),
      child: Text('Click me'),
    );
  }
}

class PointerDownListener extends SingleChildRenderObjectWidget {
  const PointerDownListener({Key? key, this.onPointerDown, Widget? child})
      : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPointerDownListener()..onPointerDown = onPointerDown;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderPointerDownListener renderObject) {
    renderObject.onPointerDown = onPointerDown;
  }
}

class RenderPointerDownListener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void handleEvent(
      PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    if (event is PointerDownEvent) onPointerDown?.call(event);
  }
}

class WaterMaskTest extends StatelessWidget {
  const WaterMaskTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

