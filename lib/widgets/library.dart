import 'package:flutter/material.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/models/library.dart';
import 'package:myfile_app/widgets/login.dart';
import 'package:provider/provider.dart';

class LibraryListPage extends StatefulWidget {
  const LibraryListPage({Key? key}) : super(key: key);

  @override
  _LibraryListPageState createState() => _LibraryListPageState();
}

class _LibraryListPageState extends State<LibraryListPage> {
  List<Library> librarys = [];

  void onPressed(List<Library> librarys) {
    setState(() {
      librarys = librarys;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(context.toString());
    return Consumer<UserModel>(builder: (context, user, child) {
      if (!user.isLogin) {
        return const LoginRoute();
      } else {
        librarys = user.user?.librarys ?? [];
        return InteractiveViewer(
            child: ListView.builder(
                itemBuilder: _itemBuilder, itemCount: librarys.length));
      }
    });
    // return const Text('data');
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: Text(librarys[index].name ?? 'name error'),
      leading: const Icon(Icons.library_books),
    );
  }
}
