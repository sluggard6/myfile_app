import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class Folder {
  Folder();

  num? id;
  num? libraryId;
  String? name;
  
  factory Folder.fromJson(Map<String,dynamic> json) => _$FolderFromJson(json);
  Map<String, dynamic> toJson() => _$FolderToJson(this);
}