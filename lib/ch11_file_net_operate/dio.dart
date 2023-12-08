import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioRoute extends StatefulWidget {
  const DioRoute({super.key});

  @override
  State<DioRoute> createState() => _DioRouteState();
}

class _DioRouteState extends State<DioRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return ListView(
              children: response.data
                  .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
