// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Folder _$FolderFromJson(Map<String, dynamic> json) => Folder()
  ..id = json['id'] as num?
  ..libraryId = json['libraryId'] as num?
  ..name = json['name'] as String?;

Map<String, dynamic> _$FolderToJson(Folder instance) => <String, dynamic>{
      'id': instance.id,
      'libraryId': instance.libraryId,
      'name': instance.name,
    };
