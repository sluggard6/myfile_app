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

  static final RegExp exp = RegExp(r"[0-9]+");

  void _decodeFile() {
    Fluttertoast.showToast(msg: widget.path);
    files = ZipDecoder()
        .decodeBytes(File(Uri.decodeComponent(widget.path)).readAsBytesSync())
        .files;
    files.sort(((f1, f2) {
      print("${f1.fileName}:${f2.fileName}");
      if (f1.fileName.isEmpty || !f1.isImage) return 1;
      if (f2.fileName.isEmpty || !f2.isImage) return -1;
      String n1 = f1.fileName.substring(
          exp.firstMatch(f1.fileName)!.start, exp.firstMatch(f1.fileName)?.end);
      String n2 = f2.fileName.substring(
          exp.firstMatch(f2.fileName)!.start, exp.firstMatch(f2.fileName)?.end);
      return int.parse(n1) - int.parse(n2);
    }));
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
            return Container(
              child: PhotoView(
                imageProvider: MemoryImage(files[index].content),
              ),
            );
            // return Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(files[index].name),
            //     PhotoView(
            //       imageProvider: MemoryImage(files[index].content),
            //     )
            //   ],
            // );
          }));
        },
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
