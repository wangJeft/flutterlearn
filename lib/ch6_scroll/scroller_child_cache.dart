//可滚动组件子项缓存
import 'package:flutter/material.dart';

class PageViewCacheWidget extends StatefulWidget {
  const PageViewCacheWidget({super.key});

  @override
  State<PageViewCacheWidget> createState() => _PageViewCacheWidgetState();
}

class _PageViewCacheWidgetState extends State<PageViewCacheWidget> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    for (int i = 0; i < 6; i++) {
      // children.add(Page(text: 'page ${i + 1}'));
      children.add(KeepAliveWrapper(child: Page(text: 'page ${i + 1}')));
    }

    return PageView(
      //置为 true 时就只会缓存前后各一页
      allowImplicitScrolling: true,
      children: children,
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  State<Page> createState() => _PageState();
}

//需要注意，如果采用 PageView.custom 构建页面时没有给列表项包装 AutomaticKeepAlive 父组件，则此方案不能正常工作，
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); //with AutomaticKeepAliveClientMixin就必须调用
    print('build ${widget.text}'); //此时所有的page只会创建一次, 就缓存起来
    return Center(child: Text(widget.text, textScaleFactor: 5));
  }

  @override
  bool get wantKeepAlive => true;
}

//封装AutomaticKeepAliveClientMixin, 如果哪个列表项需要缓存, 只需要使用 KeepAliveWrapper 包裹一下它即可
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper(
      {super.key, this.keepAlive = true, required this.child});

  final bool keepAlive;
  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
