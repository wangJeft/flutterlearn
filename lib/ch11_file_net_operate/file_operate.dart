import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperate extends StatelessWidget {
  const FileOperate({super.key});

  @override
  Widget build(BuildContext context) {
    return FileOperationRoute();
  }
}

class FileOperationRoute extends StatefulWidget {
  const FileOperationRoute({super.key});

  @override
  State<FileOperationRoute> createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      print('FileSystemException');
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("文件操作次数:"),
          Text("$_counter"),
          ElevatedButton(onPressed: _incrementCounter, child: Text("操作+1"))
        ],
      ),
    );
  }
}
