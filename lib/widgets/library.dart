import 'package:flutter/material.dart';
import 'package:myfile_app/components/http.dart';
import 'package:myfile_app/models/library.dart';

class LibraryListPage extends StatefulWidget {
  @override
  _LibraryListPageState createState() => _LibraryListPageState();
}

class _LibraryListPageState extends State<LibraryListPage> {
  List<Library> librarys = [];
  @override
  Widget build(BuildContext context) {
    // _getLibrarys(context);
    // return Consumer<UserModel>(builder: (context, user, child) {
    //   if (user.isLogin) {
    //     return const LoginRoute();
    //   } else {
    final List<int> colorCodes = <int>[600, 500, 100];
    return Center(
      child: FutureBuilder<List<Library>>(
          future: _getLibrarys(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // return Text("getLibrary count:${snapshot.data}");
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[colorCodes[index % 2]],
                    child: Text('${snapshot.data[index].name}'),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
    //   }
    // });
    // return const Text('data');
  }

  Future<List<Library>> _getLibrarys(BuildContext context) async {
    // showLoading(context);
    librarys = await MyFileHttp(context).librarys();
    return librarys;
    // try {
    //   librarys = await MyFileHttp(context).librarys();
    // } catch (e, s) {
    //   print('$e\n$s');
    // } finally {
    //   // 隐藏loading框
    //   Navigator.of(context).pop();
    // }
    // return;
  }
}