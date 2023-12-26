import 'package:flutter/material.dart';
import 'package:flutterlearn/common/common.dart';

import 'event_notification.dart';
import 'gesture_detector.dart';
import 'original_event.dart';

class EventNotifyRoute extends StatelessWidget {
  const EventNotifyRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages:[
        PagePair(name: "notify", page: NotificationRoute()),
        PagePair(name: "gesture_detect", page: GestureDetectorTest()),
        PagePair(name: "GestureWidget", page: GestureWidget()),
        PagePair(name: "原始事件", page: PointerMoveIndicator()),
      ],
      pageName: "事件处理与通知",
    );
  }
}
