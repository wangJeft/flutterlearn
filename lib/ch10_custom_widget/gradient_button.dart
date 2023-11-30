import 'package:flutter/material.dart';

class GradientButtonRoute extends StatelessWidget {
  const GradientButtonRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            onPressed: onTap,
            child: Text("Submit")),
        GradientButton(
            colors: [Colors.lightGreen, Colors.green.shade700],
            height: 50.0,
            onPressed: onTap,
            child: Text("Submit")),
        GradientButton(
            colors: [Colors.lightBlue.shade300, Colors.blueAccent],
            height: 50.0,
            onPressed: onTap,
            child: Text("Submit")),
      ]
          .map((e) => Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: e,
              ))
          .toList(),
    );
  }

  onTap() {
    print('button click');
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key,
      this.colors,
      this.width,
      this.height,
      this.borderRadius,
      this.onPressed,
      required this.child});

  final List<Color>? colors;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
