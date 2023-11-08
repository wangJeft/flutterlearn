import 'package:flutter/material.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return buildTwoSliverList();
    return buildMultiSliver();
  }

  Widget buildTwoSliverList() {
    var listView = SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("$index"),
                ),
            childCount: 20),
        itemExtent: 56);
    //使用公共的Scrollable和viewport, 来组合多个Sliver
    return CustomScrollView(
      slivers: [
        listView,
        listView,
      ],
    );
  }

  Widget buildMultiSliver() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Demo"),
            background: Image.asset(
              "images/weather.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: PageView(
              children: [
                Center(
                  child: Text(
                    "page 1",
                    textScaleFactor: 5,
                  ),
                ),
                Center(
                  child: Text(
                    "page 2",
                    textScaleFactor: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
                maxHeight: 80, minHeight: 50, child: buildHeader(1))),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        alignment: Alignment.center,
                        color: Colors.cyan[100 * (index % 9)],
                        child: Text('grid item $index'),
                      ),
                  childCount: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0)),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
                maxHeight: 80, minHeight: 50, child: buildHeader(2))),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  ),
              childCount: 20),
          itemExtent: 50.0,
        )
      ],
    );
  }

  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("Persistentheader $i"),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  SliverHeaderDelegate(
      {required this.maxHeight, this.minHeight = 0, required Widget child})
      : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  SliverHeaderDelegate.fixedHeight(
      {required double height, required Widget child})
      : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDelegate.builder(
      {required this.maxHeight, this.minHeight = 0, required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset, overlaps:$overlapsContent');
      }
      return true;
    }());
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
