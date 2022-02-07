import 'package:flutter/material.dart';
import 'package:myfile_app/components/http.dart';
import 'package:myfile_app/widgets/guide.dart';

import 'components/global.dart';

void main() {
  runApp(const MaterialApp(
    title: 'My File',
    // theme: ,
    home: SafeArea(
      child: MyFile(),
    ),
  ));
}

class MyFile extends StatelessWidget {
  const MyFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global.loadFolders();
    MyFileHttp.init();
    return const Scaffold(
      body: Guide(),
    );
  }
}

// class MainBody extends StatefulWidget {
//   const MainBody({Key? key}) : super(key: key);

//   @override
//   _MainBodyState createState() => _MainBodyState();
// }

// class _MainBodyState extends State<MainBody> {
  

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
