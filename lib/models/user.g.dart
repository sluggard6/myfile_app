// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as num?
  ..username = json['username'] as String?
  ..token = json['token'] as String?
  ..librarys = (json['librarys'] as List<dynamic>)
      .map((library) => Library.fromJson(library))
      .toList();
// ..librarys = json['librarys'] as List<Library>?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'token': instance.token,
      'librarys': instance.librarys,
    };
