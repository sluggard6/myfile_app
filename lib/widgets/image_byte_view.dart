import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../components/file_extentions.dart';

class ImageByteViewer extends StatefulWidget {
  const ImageByteViewer({Key? key, required this.bytes}) : super(key: key);
  final Uint8List bytes;
  // final String path;

  @override
  ImageByteViewerState createState() => ImageByteViewerState();
}

class ImageByteViewerState extends State<ImageByteViewer> {
  List<ArchiveFile> files = [];

  ArchiveFile getImage(int i) => files[i];

  Future<void> _decodeFile() async {
    files = ZipDecoder().decodeBytes(widget.bytes).files;
    files.sort((f1, f2) {
      return FileUtil.compileFileName(f1, f2);
    });
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
