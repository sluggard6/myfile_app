import 'package:flutter/material.dart';
import 'package:myfile_app/widgets/guide.dart';
import 'package:provider/provider.dart';

import 'components/global.dart';

void main() => Global.init().then((value) {
      runApp(
        MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => UserModel(),
              ),
            ],
            child: const MaterialApp(
              title: 'My File',
              // theme: ,
              home: SafeArea(
                child: MyFile(),
              ),
            )),
      );
    });

class MyFile extends StatelessWidget {
  const MyFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
