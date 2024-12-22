import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/components/file_extentions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfile_app/models/local_file.dart';
import 'package:myfile_app/widgets/image_view.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
// import 'package:permiss'

import 'image_byte_view.dart';
import 'image_file_view.dart';

class LocalFolder extends StatefulWidget {
  const LocalFolder({Key? key}) : super(key: key);

  @override
  LocalFolderState createState() => LocalFolderState();
}

class LocalFolderState extends State<LocalFolder> {
  final _folders = Global.files;

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
                child: const Text('导入本地目录'),
                onTap: _selectedDirectory,
              ),
              PopupMenuItem(
                child: const Text('导入本地文件'),
                onTap: _selectedZipFile,
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
      onTap: () async {
        String? name = _folders[i].name;
        String? path = _folders[i].path;
        String? type = _folders[i].type;

        if (path != null) {
          if (type == 'folder') {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ImageViewer(path: path);
            }));
          } else if (type == 'file') {
            // Uint8List bytes;
            // Future.delayed(Duration.zero, () async {
            //   return await File(path).readAsBytes();
            // }).then((value) {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //   return ImageFileViewer(bytes: value);
            // }));
            // });
            // var status = await Permission.storage.status;
            // if (status.isGranted) {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (BuildContext context) {
            //     return ImageFileViewer(path: path);
            //   }));
            // } else {
            bool isShown = await Permission.storage.shouldShowRequestRationale;
            if (await Permission.storage.request().isGranted) {
              // showLoading(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ImageFileViewer(path: path);
              }));
            }
            // }
          } else {}
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
      LocalFile f = LocalFile();
      f.name = d.name;
      f.path = selectedDirectory;
      f.type = 'folder';
      Global.files.add(f);
      Global.saveFoldersFile();
      setState(() {});
    }
  }

  _selectedZipFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['zip'],
        allowMultiple: false);
    if (result == null) return;
    // if (kIsWeb) {
    // ByteUtil.toReadable(result.files.single.bytes!, radix: Radix.dec)
    // .getBytes();
    if (result.files.single.bytes != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return ImageByteViewer(
            bytes: Uint8List.sublistView(result.files.single.bytes!, 0, null));
      }));
    }
    // } else {
    //   var file = result.files.first;
    //   LocalFile f = LocalFile();
    //   f.name = file.name;
    //   f.path = file.identifier?.substring(7);
    //   f.type = 'file';
    //   Global.files.add(f);
    //   Global.saveFoldersFile();
    //   setState(() {});
    // }
  }
}
