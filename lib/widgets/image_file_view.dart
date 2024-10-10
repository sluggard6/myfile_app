import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfile_app/components/file_extentions.dart';

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

  static final RegExp exp = RegExp(r"[0-9]+");

  void _decodeFile() {
    Fluttertoast.showToast(msg: Uri.decodeComponent(widget.path));
    // files = ZipDecoder()
    //     .decodeBytes(File(Uri.decodeComponent(widget.path)).readAsBytesSync())
    //     .files;
    files.addAll(ZipDecoder()
            .decodeBytes(File(Uri.decodeComponent(widget.path)).readAsBytesSync())
            .files);
    files.sort((f1, f2) {
      return FileUtil.compileFileName(f1, f2);
    });
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
    // InteractiveViewer.builder(builder: builder)
    return InteractiveViewer(
        child: ListView.builder(
            itemBuilder: _itemBuilder, itemCount: files.length));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
        // onTap: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (
        //     BuildContext context,
        //   ) {
        //     return Container(
        //       child: PhotoView(
        //         imageProvider: MemoryImage(files[index].content),
        //       ),
        //     );
        //   }));
        // },
        child: _getImage(files[index]));
  }

  Widget _getImage(ArchiveFile file) {
    if (file.isImage) {
      print(file.fileName);
      // return Image.memory(file.content);
      return GestureDetector(
          onLongPress: () {
            Fluttertoast.showToast(msg: "long press");
          },
          child: Stack(
            // return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.memory(file.content),
              Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Text(
                  file.fileName,
                  style: const TextStyle(
                      fontSize: 10, decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ));
    } else {
      return Text(
        file.name,
        style: const TextStyle(fontSize: 20, decoration: TextDecoration.none),
      );
    }
  }
}
