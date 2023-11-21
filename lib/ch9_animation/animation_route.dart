import 'package:flutter/material.dart';

class FadeRoute extends PageRoute {
  FadeRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  final Color? barrierColor;

  @override
  final bool barrierDismissible;

  @override
  final String? barrierLabel;

  @override
  final bool opaque;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //返回时不使用动画, 判断当前路由被激活时,是打开新的路由
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      return Padding(padding: EdgeInsets.zero);
    }
  }
}

class AnimatedRoutePageA extends StatelessWidget {
  const AnimatedRoutePageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(builder: (context) {
            return AnimatedRoutePageB();
          }));
        },
        child: Text("GoPageB"),
      ),
    );
  }
}

class AnimatedRoutePageB extends StatelessWidget {
  const AnimatedRoutePageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    );
  }
}
