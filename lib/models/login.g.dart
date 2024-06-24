// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..token = json['token'] as String?;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
