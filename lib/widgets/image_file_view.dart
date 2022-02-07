import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:myfile_app/components/file_extentions.dart';
import 'package:photo_view/photo_view.dart';

class ImageFileViewer extends StatefulWidget {
  const ImageFileViewer({Key? key, required this.bytes}) : super(key: key);
  final Uint8List bytes;

  @override
  ImageFileViewerState createState() => ImageFileViewerState();
}

class ImageFileViewerState extends State<ImageFileViewer> {
  List<ArchiveFile> files = [];

  ArchiveFile getImage(int i) => files[i];

  Future<void> _decodeFile() async {
    files = ZipDecoder().decodeBytes(widget.bytes).files;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _decodeFile).then((value) {
      setState(() {});
    });
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
      child: Image.memory(files[index].content),
    );
  }
}
