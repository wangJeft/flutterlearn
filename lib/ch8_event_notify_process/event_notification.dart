//事件通知
import 'package:flutter/material.dart';

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({super.key});

  @override
  State<NotificationRoute> createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    print('context1: $context');
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print('msg:${notification.msg}');
        return false;
      },
      child: NotificationListener<MyNotification>(
          onNotification: (notification) {
            setState(() {
              _msg += "${notification.msg}, ";
            });
            return false;
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  print('context2: $context');
                  return ElevatedButton(
                      onPressed: () => {
                            MyNotification("custom notification")
                                .dispatch(context)
                          },
                      child: Text("send notification"));
                }),
                Text(_msg)
              ],
            ),
          )),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    //指定泛型参数,监听指定类型的通知
    // return NotificationListener<ScrollEndNotification>(
    return NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }
          return false;
        },
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }));
  }*/
}

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}
