import 'package:json_annotation/json_annotation.dart';
import "folder.dart";
part 'library.g.dart';

@JsonSerializable()
class Library {
  Library();

  num? id;
  String? name;
  Folder? rootFolder;
  
  factory Library.fromJson(Map<String,dynamic> json) => _$LibraryFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}