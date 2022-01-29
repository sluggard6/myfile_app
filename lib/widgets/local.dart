import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/components/file_extentions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfile_app/models/folder.dart';
import 'package:myfile_app/widgets/image_view.dart';

class LocalFolder extends StatefulWidget {
  const LocalFolder({Key? key}) : super(key: key);

  @override
  LocalFolderState createState() => LocalFolderState();
}

class LocalFolderState extends State<LocalFolder> {
  final _folders = Global.folders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地图书'),
        actions: [
          IconButton(
              onPressed: () async {
                String os = Platform.operatingSystem;
                print(os);
                // Or, use a predicate getter.
                if (Platform.isMacOS) {
                  print('is a Mac');
                } else {
                  print('is not a Mac');
                }
              },
              icon: const Icon(Icons.list)),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text('导入本地书籍'),
                onTap: _selectedDirectory,
              )
            ];
          })
        ],
      ),
      body: ListView.builder(
          itemBuilder: _itemBuilder, itemCount: _folders.length),
    );
  }

  Widget _itemBuilder(BuildContext context, int i) {
    return ListTile(
      title: Text(_folders[i].name ?? '未命名'),
      onTap: () {
        String? name = _folders[i].name;
        String? path = _folders[i].path;
        if (path != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ImageViewer(path: path);
          }));
        } else {
          Fluttertoast.showToast(msg: '找不到 $name ...');
        }
      },
      onLongPress: () {
        final RenderSliverList button =
            context.findRenderObject()! as RenderSliverList;
        final RenderBox overlay = Navigator.of(context)
            .overlay!
            .context
            .findRenderObject()! as RenderBox;
        showMenu(
            context: context,
            position: RelativeRect.fromRect(
              button.paintBounds,
              // Rect.fromPoints(
              //   button.localToGlobal(button.of, ancestor: overlay),
              //   button.localToGlobal(
              //       button.size.bottomRight(Offset.zero) + widget.offset,
              //       ancestor: overlay),
              // ),
              Offset.zero & overlay.size,
            ),
            items: [
              PopupMenuItem(
                child: const Text('删除'),
                onTap: () {
                  Fluttertoast.showToast(msg: '删除了');
                },
              )
            ]);
      },
    );
  }

  _selectedDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      var d = Directory(selectedDirectory);
      Folder f = Folder();
      f.name = d.name;
      f.path = selectedDirectory;
      Global.folders.add(f);
      Global.saveFoldersFile();
      setState(() {});
    }
  }
}
