import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myfile_app/components/file_extentions.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  ImageViewerState createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewer> {
  List<String> index = [];

  String getImage(int i) => widget.path + "/" + index[i];
  Future<void> _loadIndex() async {
    var d = Directory(widget.path);
    var f = File(widget.path + "/.index");
    if (await f.exists()) {
      index = await f.readAsLines();
    } else {
      index = await d
          .list()
          .where((event) => event.isImage)
          .map((event) => event.name)
          .toList();
      index.sort();
      await _saveIndex(f);
    }
    // return index;
  }

  _saveIndex(File file) async {
    StringBuffer buffer = StringBuffer();
    for (var element in index) {
      buffer.writeln(element);
    }
    file.writeAsString(buffer.toString());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadIndex).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: _itemBuilder, itemCount: index.length);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    // return Image(image: AssetImage(widget.getImage(index)));
    return Image.file(File(getImage(index)));
  }
}
