import 'package:flutter/material.dart';

class ScrollControllerWidget extends StatefulWidget {
  const ScrollControllerWidget({super.key});

  @override
  State<ScrollControllerWidget> createState() => _ScrollControllerWidgetState();
}

class _ScrollControllerWidgetState extends State<ScrollControllerWidget> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false;
  String _progress = "0%";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print('${_controller.offset}');
      if (_controller.offset < 100 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滚动控制'),
      ),
      body: Scrollbar(
          child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                double progress = notification.metrics.pixels /
                    notification.metrics.maxScrollExtent;
                setState(() {
                  _progress = "${(progress * 100).toInt()}%";
                });
                print("BottomEdge: ${notification.metrics.extentAfter == 0}");
                return false;
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ListView.builder(
                      itemCount: 100,
                      itemExtent: 50.0,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("$index"),
                        );
                      }),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.black54,
                    child: Text(_progress),
                  )
                ],
              ))),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}
