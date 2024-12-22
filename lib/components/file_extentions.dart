import 'dart:io';

import 'package:archive/archive.dart';

extension FileExtention on FileSystemEntity {
  String get name {
    return path.split("/").last;
  }

  bool get isImage {
    return imageNameSet.contains(name.split(".").last.toLowerCase());
  }
}

extension ArchiveFileExtention on ArchiveFile {
  bool get isImage {
    return imageNameSet.contains(name.split(".").last.toLowerCase());
  }

  String get fileName {
    // return name.substring(name.lastIndexOf("/") + 1);
    return name.split("/").last;
  }
}

Set<String> imageNameSet = Set.from({"jpg", "jpeg", "png", "gif", "bmp"});

RegExp exp = RegExp(r"[0-9]+");

class FileUtil {
  static int compileFileName(dynamic o1, dynamic o2) {
    String f1 = analyzeName(o1);
    String f2 = analyzeName(o2);
    print("$f1:$f2");
    if (f1.isEmpty || !isImage(f1) || exp.firstMatch(f1) == null) return 1;
    if (f2.isEmpty || !isImage(f2) || exp.firstMatch(f2) == null) return -1;
    String n1 =
        f1.substring(exp.firstMatch(f1)!.start, exp.firstMatch(f1)?.end);
    String n2 =
        f2.substring(exp.firstMatch(f2)!.start, exp.firstMatch(f2)?.end);
    return int.parse(n1) - int.parse(n2);
  }

  static bool isImage(String name) {
    return imageNameSet.contains(name.split(".").last.toLowerCase());
  }

  static String analyzeName(dynamic obj) {
    if (obj is ArchiveFile) {
      return obj.fileName;
    } else if (obj is FileSystemEntity) {
      return obj.name;
    } else if (obj is String) {
      return obj;
    } else {
      throw UnsupportedError("unsupported type ${obj.runtimeType.toString()}");
    }
  }
}
