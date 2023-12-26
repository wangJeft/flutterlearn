import 'package:flutter/material.dart';
import 'package:flutterlearn/ch11_file_net_operate/dio.dart';
import 'package:flutterlearn/common/common.dart';

import 'file_operate.dart';
import 'http_client.dart';

class FileNetRoute extends StatelessWidget {
  const FileNetRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageViewRoute(
      pages: [
        PagePair(name: "Dio", page: DioRoute()),
        PagePair(name: "FileOperate", page: FileOperate()),
        PagePair(name: "httpClient", page: HttpTestRoute()),
      ],
      pageName: "FileNetOperator",
    );
  }
}
