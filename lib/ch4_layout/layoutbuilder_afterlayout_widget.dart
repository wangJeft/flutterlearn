import 'package:flutter/material.dart';

class LayoutBuilderAfterLayout extends StatefulWidget {
  const LayoutBuilderAfterLayout({super.key});

  @override
  State<LayoutBuilderAfterLayout> createState() =>
      _LayoutBuilderAfterLayoutState();
}

class _LayoutBuilderAfterLayoutState extends State<LayoutBuilderAfterLayout> {
  @override
  Widget build(BuildContext context) {
    var children = List.filled(6,Text("A"));
    return Column(
      children: [
        SizedBox(width: 190, child: ResponsiveColumn(children: children),),
        ResponsiveColumn(children: children),
        LayoutLogPrint(child: Text("xx")),
      ],
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //根据父组件传递的约束信息动态的构建布局
      if (constraints.maxWidth < 200) {
        return Column(mainAxisSize: MainAxisSize.min, children: children);
      } else {
        var _children = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            _children.add(Row(
              mainAxisSize: MainAxisSize.min,
              children: [children[i], children[i + 1]],
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(mainAxisSize: MainAxisSize.min, children: _children);
      }
    });
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}