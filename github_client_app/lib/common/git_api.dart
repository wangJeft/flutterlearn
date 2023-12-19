import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../index.dart';
export 'package:dio/dio.dart' show DioException;

class Git {
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;
  late Options _options;

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.github.com/',
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    if (!Global.isRelease) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return null;
      };
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        HttpClient httpClient =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        httpClient.badCertificateCallback = (cert, host, port) => true;
        return httpClient;
      };
    }
  }

  Future<User> login(String login, String pwd) async {
    String basic = 'Basic ${base64.encode(utf8.encode('$login:$pwd'))}';
    var r = await dio.get(
      "/user",
      options: _options.copyWith(
        headers: {HttpHeaders.authorizationHeader: basic},
        extra: {
          "noCache": true,
        },
      ),
    );
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.netCache.cache.cast();
    //更新profile中的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  Future<List<Repo>> getRepos(
      {Map<String, dynamic>? queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra!.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data!.map((e) => Repo.fromJson(e)).toList();
  }
}
