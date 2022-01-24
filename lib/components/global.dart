import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfile_app/models/profile.dart';
import 'package:myfile_app/models/user.dart';
import 'package:path_provider/path_provider.dart';

import 'net_cache.dart';

class Global {
  // static SharedPreferences _prefs;
  static Profile profile = Profile();

  static NetCache netCache = NetCache();

  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  // 持久化Profile信息
  static saveProfile() async =>
      (await (await _getProfileFile()).writeAsString(profile.toString()));
  // await _getProfileFile();

  // _prefs.setString("profile", jsonEncode(profile.toJson()));
  static Future<File> _getProfileFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/profile.json');
  }

  static bool get isLogined => profile.user == null;
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User? get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => _profile.user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User? user) {
    // _profile.user = user;
    // notifyListeners();
    if (user?.id != _profile.user?.id) {
      // _profile.lastLogin = user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}
