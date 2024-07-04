// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) => Library()
  ..id = json['id'] as num?
  ..name = json['name'] as String?
  ..rootFolder = json['rootFolder'] == null
      ? null
      : Folder.fromJson(json['rootFolder'] as Map<String, dynamic>);

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rootFolder': instance.rootFolder,
    };
