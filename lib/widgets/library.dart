import 'package:flutter/material.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/widgets/login.dart';
import 'package:provider/provider.dart';

class LibraryListPage extends StatefulWidget {
  @override
  _LibraryListPageState createState() => _LibraryListPageState();
}

class _LibraryListPageState extends State<LibraryListPage> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<UserModel>(builder: (context, user, child) {
    //   Widget widget;
    //   if (user.isLogin) {
    //     return LoginRoute();
    //   } else {}
    // });
    return const Text('data');
  }
}
