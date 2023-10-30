import 'package:flutter/material.dart';

class TextFieldFormWidget extends StatefulWidget {
  const TextFieldFormWidget({super.key});

  @override
  State<TextFieldFormWidget> createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
/*  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusScopeNode? focusScopeNode;*/
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
/*    _nameController.text = "init name";
    _nameController.selection =
        TextSelection(baseOffset: 3, extentOffset: _nameController.text.length);*/
    //controller 监听文本变化
/*    _passwordController.addListener(() {
      print(_passwordController.text);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            autocorrect: true,
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: "用户名或者邮箱",
              prefixIcon: Icon(Icons.person),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
            ),
            onChanged: (v) {
              print(v);
            },
            // controller: _nameController,
            // focusNode: nameFocusNode,
          ),
          TextField(
            autocorrect: true,
            decoration: InputDecoration(
                labelText: '密码',
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)),
            obscureText: true,
            // controller: _passwordController,
            // focusNode: passwordFocusNode,
          ),
          SizedBox(height: 20.0),
          Builder(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // print(_passwordController.text);
                    },
                    child: Text("获取密码")),
                ElevatedButton(
                    onPressed: () {
                      /*focusScopeNode ??= FocusScope.of(context);
                      */ /*  if (nameFocusNode.hasFocus) {
                        focusScopeNode?.requestFocus(passwordFocusNode);
                      } else {*/ /*
                      focusScopeNode?.requestFocus(nameFocusNode);
                      // }*/
                    },
                    child: Text("移动焦点")),
                ElevatedButton(
                    onPressed: () {
                      /*  nameFocusNode.unfocus();
                      passwordFocusNode.unfocus();*/
                    },
                    child: Text("隐藏键盘")),
              ],
            );
          }),
          SizedBox(height: 20.0),
          Text("Form"),
          SizedBox(height: 20.0),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: '用户名',
                      hintText: "用户名或者邮箱",
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    onChanged: (v) {
                      print(v);
                    },
                    validator: (v) {
                      return v!.trim().isNotEmpty ? null : "用户名不能为空";
                    },
                  ),
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: '密码',
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: (v) {
                      return v!.trim().length > 5 ? null : "密码不能小于6位";
                    },
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("登录"),
                  ),
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      //提交数据
                    }
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
