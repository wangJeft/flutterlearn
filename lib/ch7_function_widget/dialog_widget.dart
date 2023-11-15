import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  bool? delete = await showDeleteConfirmDialog(context);
                  if (delete == null) {
                    print('取消删除');
                  } else {
                    print('确认删除');
                  }
                },
                child: Text("删除对话框")),
            ElevatedButton(
                onPressed: () {
                  changeLanguageDialog(context);
                },
                child: Text("选择语言")),
            ElevatedButton(
                onPressed: () {
                  showListDialog(context);
                },
                child: Text("ListDialog")),
            ElevatedButton(
                onPressed: () {
                  showCustomDialogV(context);
                },
                child: Text("自定义内容dialog")),
            ElevatedButton(
                onPressed: () async {
                  await showDeleteConfirmDialogV2(context);
                },
                child: Text("删除对话框V2")),
            ElevatedButton(
                onPressed: () async {
                  bool? confirm = await showDeleteConfirmDialogV3(context);
                  if (confirm == null) {
                    print('取消删除');
                  } else {
                    print('确认删除');
                  }
                },
                child: Text("删除对话框V3")),
            ElevatedButton(
                onPressed: () async {
                  bool? confirm = await showDeleteConfirmDialogV4(context);
                  if (confirm == null) {
                    print('取消删除');
                  } else {
                    print('确认删除');
                  }
                },
                child: Text("删除对话框V4")),
            ElevatedButton(
                onPressed: () async {
                  bool? confirm = await showDeleteConfirmDialogV5(context);
                  if (confirm == null) {
                    print('取消删除');
                  } else {
                    print('确认删除');
                  }
                },
                child: Text("删除对话框V5")),
            ElevatedButton(
                onPressed: () async {
                  int? confirm = await _showModalBottomSheet(context);
                  print('select $confirm');
                },
                child: Text("bottomSheet")),
            ElevatedButton(
                onPressed: () async {
                  showLoadingDialog(context);
                },
                child: Text("loading dialog")),
            ElevatedButton(
                onPressed: () async {
                  _showDatePicker1(context);
                },
                child: Text("DatePicker1")),
          ],
        ),
      ),
    );
  }

  Future<bool?> showDeleteConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("删除"))
            ],
          );
        });
  }

  Future<void> changeLanguageDialog(BuildContext context) async {
    int? i = await showDialog<int>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("请选择语言"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("中文简体"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("美国英语"),
                ),
              ),
            ],
          );
        });
    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  Future<void> showListDialog(BuildContext context) async {
    int? index = await showDialog(
        context: context,
        builder: (context) {
          var child = Column(
            children: [
              ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${index + 1}"),
                        onTap: () => Navigator.of(context).pop(index),
                      );
                    }),
              )
            ],
          );
          return Dialog(
            child: child,
          );
        });

    if (index != null) {
      print("点击了：${index + 1}");
    }
  }

  Future<void> showCustomDialogV(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280, maxHeight: 300),
              child: Material(
                type: MaterialType.card,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("images/weather.png"),
                ),
              ),
            ),
          );
        });
  }

  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
    ThemeData? theme,
  }) {
    final ThemeData theme0 = Theme.of(context);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(child: Builder(builder: (context) {
            return theme != null
                ? Theme(data: theme0, child: pageChild)
                : pageChild;
          }));
        },
        barrierDismissible: barrierDismissible,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black87,
        transitionDuration: Duration(milliseconds: 1500),
        transitionBuilder: _buildMaterialDialogTransitions);
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }

  Future<bool?> showDeleteConfirmDialogV2(BuildContext context) {
    return showCustomDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("删除"))
            ],
          );
        });
  }

  Future<bool?> showDeleteConfirmDialogV3(BuildContext context) {
    bool _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("确定删除?"),
                Row(
                  children: [
                    Text("同时删除子目录?"),
                    //组件的状态使用StatefulWidget封装起来
                    DialogCheckbox(
                        value: _withTree,
                        onChanged: (value) {
                          _withTree = !_withTree;
                        })
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: Text("删除"))
            ],
          );
        });
  }

  Future<bool?> showDeleteConfirmDialogV4(BuildContext context) {
    bool _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("确定删除?"),
                Row(
                  children: [
                    Text("同时删除子目录?"),
                    //组件的状态使用StatefulWidget封装起来
                    StatefulBuilder(builder: (context, setState) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (value) {
                            setState(() {
                              _withTree = !_withTree;
                            });
                          });
                    })
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: Text("删除"))
            ],
          );
        });
  }

  Future<bool?> showDeleteConfirmDialogV5(BuildContext context) {
    bool _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("确定删除?"),
                Row(
                  children: [
                    Text("同时删除子目录?"),
                    Builder(builder: (context) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (value) {
                            //标记当前的Element对象为dirty的方式, 达到重构组件的目的
                            (context as Element).markNeedsBuild();
                            _withTree = !_withTree;
                          });
                    })
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: Text("删除"))
            ],
          );
        });
  }

  Future<int?> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              });
        });
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 250,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 26.0),
                      child: Text("Loading"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime?> _showDatePicker1(BuildContext context) {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(Duration(days: 30)));
  }
}

class DialogCheckbox extends StatefulWidget {
  const DialogCheckbox({super.key, this.value, required this.onChanged});

  final ValueChanged<bool?> onChanged;
  final bool? value;

  @override
  State<DialogCheckbox> createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (v) {
          widget.onChanged(v);
          setState(() {
            value = v;
          });
        });
  }
}

class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({super.key, required this.builder});

  final StatefulWidgetBuilder builder;

  @override
  State<StatefulBuilder> createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}
