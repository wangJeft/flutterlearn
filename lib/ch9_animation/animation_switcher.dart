import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({super.key});

  @override
  State<AnimatedSwitcherCounterRoute> createState() =>
      _AnimatedSwitcherCounterRouterState();
}

class _AnimatedSwitcherCounterRouterState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Text(
              '$_count',
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return MySlideTransition(
                position: tween.animate(animation),
                child: child,
              );
            },
            child: Text(
              '$_count',
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 3000),
            transitionBuilder: (child, animation) {
              return SlideTransitionX(
                position: animation,
                direction: AxisDirection.left,
                child: child,
              );
            },
            child: Text(
              '$_count',
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
              child: Text("+1"))
        ],
      ),
    );
  }
}

class MySlideTransition extends AnimatedWidget {
  const MySlideTransition(
      {Key? key,
      required Animation<Offset> position,
      this.transformHitTests = true,
      required this.child})
      : super(key: key, listenable: position);
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX(
      {Key? key,
      required Animation<double> position,
      this.transformHitTests = true,
      this.direction = AxisDirection.down,
      required this.child})
      : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.down:
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return ScaleTransition(
      scale: position,
      child: FractionalTranslation(
        translation: offset,
        transformHitTests: transformHitTests,
        child: child,
      ),
    );
    /* return  FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );*/
  }
}
