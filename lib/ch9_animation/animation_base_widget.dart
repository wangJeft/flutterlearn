import 'package:flutter/material.dart';

import 'animation_route.dart';
import 'hero_animation.dart';
import 'mutil_animation.dart';

class AnimationBaseWidget extends StatelessWidget {
  const AnimationBaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return ScaleAnimationRoute();
    // return ScaleAnimationRoute1();
    // return ScaleAnimationRoute2();
    // return AnimatedRoutePageA();
    // return CustomHeroAnimation();
    // return HeroAnimationRouteA();
    return StaggerRoute();
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({super.key});

  @override
  State<ScaleAnimationRoute> createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);

    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "images/weather.png",
        width: animation.value,
        height: animation.value,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//使用AnimatedWidget改造
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "images/weather.png",
        width: animation.value,
        height: animation.value,
        fit: BoxFit.fill,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  const ScaleAnimationRoute1({super.key});

  @override
  State<ScaleAnimationRoute1> createState() => _ScaleAnimationRouteState1();
}

class _ScaleAnimationRouteState1 extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);

    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//使用AnimatedBuilder改造, 不用显示调用setState, 缩小rebuild范围

class ScaleAnimationRoute2 extends StatefulWidget {
  const ScaleAnimationRoute2({super.key});

  @override
  State<ScaleAnimationRoute2> createState() => _ScaleAnimationRouteState2();
}

class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);

    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if(status == AnimationStatus.dismissed){
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    /*return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Center(
            child: SizedBox(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          );
        },
        child: Image.asset("images/weather.png", fit: BoxFit.fill));*/
    return GrowTransition(
      animation: animation,
      child: Image.asset("images/weather.png", fit: BoxFit.fill),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({super.key, required this.animation, this.child});

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
