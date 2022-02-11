import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfile_app/components/file_extentions.dart';
import 'package:photo_view/photo_view.dart';

class ImageFileViewer extends StatefulWidget {
  const ImageFileViewer({Key? key, required this.path}) : super(key: key);
  // final Uint8List bytes;
  final String path;

  @override
  ImageFileViewerState createState() => ImageFileViewerState();
}

class ImageFileViewerState extends State<ImageFileViewer> {
  List<ArchiveFile> files = [];

  ArchiveFile getImage(int i) => files[i];

  void _decodeFile() {
    Fluttertoast.showToast(msg: widget.path);
    files = ZipDecoder()
        .decodeBytes(File(Uri.decodeComponent(widget.path)).readAsBytesSync())
        .files;
    Fluttertoast.showToast(msg: "success decode files : ${files.length}");
  }

  @override
  void initState() {
    super.initState();
    _decodeFile();
    // Navigator.of(context).pop();
    setState(() {});
    // Future.delayed(Duration.zero, _decodeFile).then((value) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: _itemBuilder, itemCount: files.length);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    // return Image(image: AssetImage(widget.getImage(index)));
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (
            BuildContext context,
          ) {
            // return Center(child: Image.file(File(getImage(index))));
            return Container(
              child: PhotoView(
                imageProvider: MemoryImage(files[index].content),
              ),
            );
          }));
        },
        child: _getImage(files[index]));
  }

  Widget _getImage(ArchiveFile file) {
    if (file.isImage) {
      return Image.memory(file.content);
    } else {
      return Text(file.name);
    }
  }
}
