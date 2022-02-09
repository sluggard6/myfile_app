import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfile_app/models/http_result.dart';
import 'package:myfile_app/models/user.dart';

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
    baseUrl: 'http://127.0.0.1:5678/',
    headers: {
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
      onResponse: (e, handler) {
        e.data = HttpResult.fromJson(e.data);
        handler.next(e);
      },
    ));
    if (!Global.isRelease &&
        dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // client.findProxy = (uri) {
        //   return "PROXY 10.1.10.250:8888";
        // };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future<User> login(String username, String password) async {
    var r = await dio.post('user/login',
        options: Options(extra: {"noCache": true}),
        data: json.encode({"username": username, "password": password}));
    // dio.fetch(requestOptions)
    HttpResult res = r.data as HttpResult;
    return User.fromJson(res.data?['user'] ?? {});
  }
}
