//异步更新ui

import 'package:flutter/material.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(
      Duration(seconds: 5), () => "FutureBuilder fetch data from remote");
}

class FutureBuilderWidget extends StatelessWidget {
  const FutureBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: mockNetworkData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("Contents: ${snapshot.data}");
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 3), (i) {
    return i;
  });
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: counter(), builder: (context,snapshot){
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text('没有Stream');
        case ConnectionState.waiting:
          return Text('等待数据...');
        case ConnectionState.active:
          return Text('active: ${snapshot.data}');
        case ConnectionState.done:
          return Text('Stream 已关闭');
      }
    });
  }
}
