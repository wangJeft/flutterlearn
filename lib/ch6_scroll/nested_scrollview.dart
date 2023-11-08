import 'package:flutter/material.dart';
import 'package:flutterlearn/ch6_scroll/custom_sliver.dart';

class NestedScrollViewWidget extends StatelessWidget {
  const NestedScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              title: Text("NestedScrollView"),
            ),
            buildSliverList(5)
          ];
        },
        body: ListView.builder(
            padding: EdgeInsets.all(8),
            physics: ClampingScrollPhysics(),
            itemCount: 30,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 50,
                child: Center(
                  child: Text('Item $index'),
                ),
              );
            }));
  }
}

class SnapAppBar extends StatelessWidget {
  const SnapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return buildScaffold2();
  }

  Scaffold buildScaffold2() {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.asset("images/weather.png", fit: BoxFit.cover),
              ),
            ),
          )
        ];
      },
      body: Builder(builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            buildSliverList(100)
          ],
        );
      }),
    ));
  }

  //这种方案, SliverAppBar,会挡住body中的内容
  Scaffold buildScaffold1() {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 200,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/weather.png", fit: BoxFit.cover),
            ),
          )
        ];
      },
      body: Builder(builder: (context) {
        return CustomScrollView(
          slivers: [buildSliverList(100)],
        );
      }),
    ));
  }
}

class NestedTabBarViewWidget extends StatelessWidget {
  const NestedTabBarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _tabs = ['猜你喜欢', '今日特价', '发现更多'];
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: Text("商城"),
                    floating: true,
                    snap: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      tabs: _tabs
                          .map((e) => Tab(
                                text: e,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs
                  .map((e) => Builder(builder: (context) {
                        return CustomScrollView(
                          key: PageStorageKey(e),
                          slivers: [
                            SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context)),
                            SliverPadding(
                              padding: EdgeInsets.all(8.0),
                              sliver: buildSliverList(50),
                            )
                          ],
                        );
                      }))
                  .toList(),
            ),
          ),
        ));
  }
}
