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
    return name.substring(name.lastIndexOf("/") + 1);
  }
}

Set<String> imageNameSet = Set.from({"jpg", "jpeg", "png", "gif", "bmp"});
