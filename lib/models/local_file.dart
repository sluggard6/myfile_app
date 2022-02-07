import 'package:json_annotation/json_annotation.dart';

part 'local_file.g.dart';

@JsonSerializable()
class LocalFile {
  LocalFile();

  String? name;
  String? path;
  String? type;
  
  factory LocalFile.fromJson(Map<String,dynamic> json) => _$LocalFileFromJson(json);
  Map<String, dynamic> toJson() => _$LocalFileToJson(this);
}