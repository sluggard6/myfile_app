import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfile_app/models/http_result.dart';
import 'package:myfile_app/models/library.dart';
import 'package:myfile_app/models/login.dart';
import 'package:myfile_app/models/user.dart';
import 'package:oktoast/oktoast.dart';

import 'global.dart';

class MyFileHttp {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  // Http([this.context]) {
  //   _options = Options(extra: {"context": context});
  // }
  MyFileHttp([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;
  Options? _options;

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:5678/myfile/',
    headers: {
      HttpHeaders.authorizationHeader: Global.profile.token,
      // HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      // HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
      // "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    // 添加缓存插件
    // dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print(options.data);
        handler.next(options);
      },
      onResponse: (e, handler) {
        e.data = HttpResult.fromJson(e.data);
        handler.next(e);
      },
      onError: (error, handler) {
        print(error);
        showToast("网络错误");
      },
    ));
    // dio.interceptors.add(Cookie)
    if (!Global.isRelease && dio.httpClientAdapter is IOHttpClientAdapter) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        // client.findProxy = (uri) {
        //   return "PROXY 10.1.10.250:8888";
        // };
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
  }

  Future<User> login(String username, String password) async {
    // try {
    var r = await dio.post('user/login',
        options: Options(extra: {"noCache": true}),
        data: json.encode({"username": username, "password": password}));
    // dio.fetch(requestOptions)
    HttpResult res = r.data as HttpResult;
    if (res.code == 0) {
      var token = res.data['token'];
      Global.profile.token = token;
      dio.options.headers["Authorization"] = res.data?['token'];
    }
    return User.fromJson(res.data['user']);
    // return User.fromJson(res.data?['user'] ?? {});
    // } catch (e) {
    //   print("$e");
    //   showToast("网络异常");
    //   return null;
    // }
  }

  Future<List<Library>> librarys() async {
    var r =
        await dio.get('/library', options: Options(extra: {"noCache": true}));
    HttpResult res = r.data as HttpResult;
    if (kDebugMode) {
      print(res.data.runtimeType);
    }
    return List<Library>.from(
        res.data.map((m) => Library.fromJson(m)).toList());
    // json
    //     .decode(res.data as String)
    //     .map((m) => Library.fromJson(m))
    //     .toList();
  }
}
