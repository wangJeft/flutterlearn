import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterlearn/ch4_layout/layoutbuilder_afterlayout_widget.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return DividerListView();
    // return FixedExtentList();
    // return InfiniteListView();
    return ListHeadListView();
  }
}

class DividerListView extends StatelessWidget {
  const DividerListView({super.key});

  @override
  Widget build(BuildContext context) {
    /* return ListView.builder(
        itemCount: 100,
        itemExtent: 50,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("index: $index"),
          );
        });
  }*/
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("index: $index"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
          // return Text("分割");
        },
        itemCount: 100);
  }
}

class FixedExtentList extends StatelessWidget {
  const FixedExtentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        /* prototypeItem: ListTile(
          title: Text("1"),
        ),*/
        itemBuilder: (context, index) {
      return LayoutLogPrint(
          tag: index,
          child: ListTile(
            title: Text("$index"),
          ));
    });
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (_words[index] == loadingTag) {
            //数据不足100条, 继续获取数据
            if (_words.length - 1 < 100) {
              _retrieveData();
              return Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              //已经加载了100条数据，不再获取数据
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          return ListTile(
            title: Text(_words[index]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: _words.length);
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}

class ListHeadListView extends StatefulWidget {
  const ListHeadListView({super.key});

  @override
  State<ListHeadListView> createState() => _ListHeadListViewState();
}

class _ListHeadListViewState extends State<ListHeadListView> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("单词列表"),
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  if (_words[index] == loadingTag) {
                    //数据不足100条, 继续获取数据
                    if (_words.length - 1 < 100) {
                      _retrieveData();
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      //已经加载了100条数据，不再获取数据
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  }
                  return ListTile(
                    title: Text(_words[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0,
                  );
                },
                itemCount: _words.length))
      ],
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
