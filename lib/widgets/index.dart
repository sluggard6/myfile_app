import 'package:flutter/material.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/models/user.dart';
import 'package:myfile_app/widgets/login.dart';
import 'package:provider/provider.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  int currentIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> pages = <Widget>[
    Consumer<UserModel>(
      builder: (context, user, child) {
        String? text = user.isLogin ? user.user?.username : 'default';
        return ElevatedButton(
            onPressed: () => {
                  if (!user.isLogin)
                    {
                      user.user =
                          User.fromJson({"id": 1, "username": "logined"})
                    }
                  else
                    {user.user = null}
                },
            child: Text(
              '${user.isLogin}',
              style: optionStyle,
            ));
      },
    ),
    Consumer<UserModel>(builder: (context, user, child) {
      if (user.isLogin) {
        return const Center(
          child: Text('logined'),
        );
      } else {
        return const GoLogin();
      }
    }),
    // LoginRoute()
    const Text('23423')
  ];

  // _changeLogin(UserModel? user) {
  //   if(user?.isLogin){
  //     user.user =;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temp Title"),
      ),
      body: Center(child: pages.elementAt(currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: '云端',
              activeIcon: Icon(Icons.cloud_download)),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '文件'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '我的'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget showLoding(BuildContext context) {
  // context
  return CircularProgressIndicator(
    backgroundColor: Colors.grey[200],
    valueColor: AlwaysStoppedAnimation(Colors.blue),
  );
}
// class BottomBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class GoLogin extends StatelessWidget {
  const GoLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('请先登陆'),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) {
                return LoginRoute();
              }));
            },
            child: const Text('去登陆'))
      ],
    );
  }
}
