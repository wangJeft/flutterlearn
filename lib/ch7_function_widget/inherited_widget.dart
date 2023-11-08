import 'package:flutter/material.dart';

class DataShareTestWidget extends StatefulWidget {
  const DataShareTestWidget({super.key});

  @override
  State<DataShareTestWidget> createState() => _DataShareTestWidgetState();
}

class _DataShareTestWidgetState extends State<DataShareTestWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: DataShareWidget(),
            ),
            ElevatedButton(
                onPressed: () => setState(() {
                      ++count;
                    }),
                child: Text("Increment"))
          ],
        ),
      ),
    );
  }
}

class DataShareWidget extends StatefulWidget {
  const DataShareWidget({super.key});

  @override
  State<DataShareWidget> createState() => _DataShareWidgetState();
}

class _DataShareWidgetState extends State<DataShareWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print('Dependencies change');
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  final int data;

  static ShareDataWidget of(BuildContext context) {
    /*final ShareDataWidget? result =
        context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    assert(result != null, 'No ShareDataWidget found in context');
    return result!;*/
    //下面的方法可以时数据发生变化时, 子widget的didChangeDependencies不再回调,
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()!
        .widget as ShareDataWidget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
