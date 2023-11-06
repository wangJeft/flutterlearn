import 'package:flutter/material.dart';

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({super.key});

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  var data = <String>[];
  int counter = 5;
  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < counter; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
            key: globalKey,
            initialItemCount: data.length,
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: _buildItem(context, index),
              );
            }),
        _buildAddBtn()
      ],
    );
  }

  Widget _buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: FloatingActionButton(
        onPressed: () {
          data.add("${++counter}");
          globalKey.currentState!.insertItem(data.length - 1);
          print('添加 $counter');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      globalKey.currentState!.removeItem(index, (context, animation) {
        var item = _buildItem(context, index);
        print('删除 ${data[index]}');
        data.removeAt(index);
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: item,
          ),
        );
      }, duration: Duration(milliseconds: 200));
    });
  }
}
