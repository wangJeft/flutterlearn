import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("ElevatedButton")),
          SizedBox(height: 10.0),
          TextButton(onPressed: () {}, child: Text("TextButton")),
          SizedBox(height: 10.0),
          OutlinedButton(onPressed: () {}, child: Text("OutlinedButton")),
          SizedBox(height: 10.0),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite_border_rounded)),
          SizedBox(height: 10.0),
          ElevatedButton.icon(
            icon: Icon(Icons.send),
            label: Text("发送"),
            onPressed: (){},
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.add),
            label: Text("添加"),
            onPressed:  (){},
          ),
          TextButton.icon(
            icon: Icon(Icons.info),
            label: Text("详情"),
            onPressed:  (){},
          ),
        ],
      ),
    );
  }
}
