// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..cacheConfig = json['cacheConfig'] == null
      ? null
      : CacheConfig.fromJson(json['cacheConfig'] as Map<String, dynamic>)
  ..token = json['token'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'cacheConfig': instance.cacheConfig,
      'token': instance.token,
    };
