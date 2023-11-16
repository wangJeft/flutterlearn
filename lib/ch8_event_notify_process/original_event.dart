import 'package:flutter/material.dart';

class PointerMoveIndicator extends StatefulWidget {
  const PointerMoveIndicator({super.key});

  @override
  State<PointerMoveIndicator> createState() => _PointerMoveIndicatorState();
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicator> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300,
            height: 150,
            child: Text(
              '${_event?.localPosition ?? ''}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPointerDown: (PointerDownEvent event) => setState(() {
            _event = event;
          }),
          onPointerMove: (PointerMoveEvent event) => setState(() {
            _event = event;
          }),
          onPointerUp: (PointerUpEvent event) => setState(() {
            _event = event;
          }),
        ),
        SizedBox(
          height: 50,
        ),
        //AbsorbPointer让子树不响应指针事件, 但是其本身会参与命中测试
        //IgnorePointer让子树不响应指针事件, 但是其本身不会参与命中测试
        Listener(
          child: AbsorbPointer(
            child: Listener(
              child: Container(
                color: Colors.red,
                width: 200,
                height: 100,
              ),
              onPointerDown: (event) => print('in'),
            ),
          ),
          onPointerDown: (event) => print('up'),
        )
      ],
    );
  }
}
