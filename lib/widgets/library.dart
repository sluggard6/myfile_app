import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/components/http.dart';
import 'package:myfile_app/main.dart';
import 'package:myfile_app/models/library.dart';
import 'package:provider/provider.dart';

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
    final List<int> colorCodes = <int>[50, 100, 600, 500];
    return Scaffold(
        appBar: AppBar(
          title: const Text('我的云盘'),
        ),
        body: Center(
          child: FutureBuilder<List<Library>>(
              future: _getLibrarys(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // return Text("getLibrary count:${snapshot.data}");
                  print(snapshot.data);
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.cyan[colorCodes[index % 2]],
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // crossAxisCount: 2,
                          // childAspectRatio: 2,
                          children: [
                            // Text('${snapshot.data[index].name}'),
                            // Text('${snapshot.data[index].rootFolder.name}'),
                            Expanded(
                              flex: 1,
                              child: Text('${snapshot.data[index].name}'),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                    child: IconButton(
                                        onPressed: deleteLibrary(),
                                        icon: const Icon(Icons.delete))),
                                Expanded(
                                    child: IconButton(
                                        onPressed: deleteLibrary(),
                                        icon: const Icon(Icons.share)))
                              ],
                            )

                                // Text(
                                //     '${snapshot.data[index].rootFolder.name}'),
                                ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
    //   }
    // });
    // return const Text('data');
  }

  deleteLibrary() {
    print("button clecked");
    // showLoading(context);
    // await MyFileHttp(context).deleteLibrary(librarys[index].id);
    // Navigator.of(context).pop();
  }

  Future<List<Library>> _getLibrarys(BuildContext context) async {
    // showLoading(context);
    librarys = await MyFileHttp(context).librarys();
    return librarys;
  }
}
