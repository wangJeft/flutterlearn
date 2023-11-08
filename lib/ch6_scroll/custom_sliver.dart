import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverWidget extends StatelessWidget {
  const CustomSliverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverFlexibleHeader(
          visibleExtent: 200,
          builder: (context, availableHeight, direction) {
            return GestureDetector(
              onTap: () => print('tap'),
              child: Image(
                image: AssetImage("images/weather.png"),
                width: 50.0,
                height: availableHeight,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        buildSliverList(30)
      ],
    );
  }
}

Widget buildSliverList(int count) {
  return SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
              title: Text("$index"),
            ),
        childCount: count),
    itemExtent: 56,
  );
}

typedef SliverFlexibleHeaderBuilder = Widget Function(
    BuildContext context, double maxExtent, ScrollDirection direction);

class SliverFlexibleHeader extends StatelessWidget {
  const SliverFlexibleHeader(
      {Key? key, this.visibleExtent = 0, required this.builder})
      : super(key: key);

  final SliverFlexibleHeaderBuilder builder;
  final double visibleExtent;

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(
        visibleExtent: visibleExtent,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return builder(
                context,
                constraints.maxHeight,
                (constraints as ExtraInfoBoxConstraints<ScrollDirection>)
                    .extra);
          },
        ));
  }
}

class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _SliverFlexibleHeader({
    Key? key,
    required Widget child,
    this.visibleExtent = 0,
  }) : super(key: key, child: child);

  final double visibleExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(
      BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject.visibleExtent = visibleExtent;
  }
}

class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;
  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  late double _visibleExtent = 0;

  ScrollDirection _direction = ScrollDirection.idle;

  // 该变量用来确保Sliver完全离开屏幕时会通知child且只通知一次.
  bool _reported = false;

// 是否需要修正scrollOffset. _visibleExtent 值更新后，
  // 为了防止突然的跳动，要先修正 scrollOffset。
  double? _scrollOffsetCorrection;

  set visibleExtent(double value) {
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _reported = false;
      _scrollOffsetCorrection = value - _visibleExtent;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
// _visibleExtent 值更新后，为了防止突然的跳动，先修正 scrollOffset
    if (_scrollOffsetCorrection != null) {
      geometry =
          SliverGeometry(scrollOffsetCorrection: _scrollOffsetCorrection);
      _scrollOffsetCorrection = null;
      return;
    }

    // 滑动距离大于_visibleExtent时则表示子节点已经在屏幕之外了
    if (child == null || (constraints.scrollOffset > _visibleExtent)) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    if (constraints.scrollOffset > _visibleExtent) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      if (!_reported) {
        _reported = true;
        child!.layout(
            ExtraInfoBoxConstraints(
                _direction, constraints.asBoxConstraints(maxExtent: 0)),
            parentUsesSize: false);
      }
      return;
    }

    _reported = false;

    // 测试overlap,下拉过程中overlap会一直变化.
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;
    _direction = ScrollDirection.idle;

    var distance = overScroll > 0
        ? overScroll - _lastOverScroll
        : _lastOverScroll - scrollOffset;
    _lastOverScroll = overScroll;
    _lastScrollOffset = scrollOffset;

    if (constraints.userScrollDirection == ScrollDirection.idle) {
      _direction = ScrollDirection.idle;
      _lastOverScroll = 0;
    } else if (distance > 0) {
      _direction = ScrollDirection.forward;
    } else if (distance < 0) {
      _direction = ScrollDirection.reverse;
    }

    // 在Viewport中顶部的可视空间为该 Sliver 可绘制的最大区域。
    // 1. 如果Sliver已经滑出可视区域则 constraints.scrollOffset 会大于 _visibleExtent，
    //    这种情况我们在一开始就判断过了。
    // 2. 如果我们下拉超出了边界，此时 overScroll>0，scrollOffset 值为0，所以最终的绘制区域为
    //    _visibleExtent + overScroll.
    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    // 绘制高度不超过最大可绘制空间
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    //对子组件进行布局，关于 layout 详细过程我们将在本书后面布局原理相关章节详细介绍，现在只需知道
    //子组件通过 LayoutBuilder可以拿到这里我们传递的约束对象（ExtraInfoBoxConstraints）
    child!.layout(
        ExtraInfoBoxConstraints(
            _direction, constraints.asBoxConstraints(maxExtent: paintExtent)),
        parentUsesSize: false);

    //最大为_visibleExtent，最小为 0
    double layoutExtent = min(_visibleExtent, paintExtent);

    geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: -overScroll,
        paintExtent: paintExtent,
        maxPaintExtent: paintExtent,
        layoutExtent: layoutExtent);
  }
}

class ExtraInfoBoxConstraints<T> extends BoxConstraints {
  ExtraInfoBoxConstraints(this.extra, BoxConstraints constraints)
      : super(
            minWidth: constraints.minWidth,
            minHeight: constraints.minHeight,
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight);
  final T extra;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExtraInfoBoxConstraints &&
        super == other &&
        other.extra == extra;
  }

  @override
  int get hashCode => hashValues(super.hashCode, extra);
}
