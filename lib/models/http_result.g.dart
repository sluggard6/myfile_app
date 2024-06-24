// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult _$HttpResultFromJson(Map<String, dynamic> json) => HttpResult()
  ..code = json['code'] as num?
  ..message = json['message'] as String?
  ..data = json['data'];

Map<String, dynamic> _$HttpResultToJson(HttpResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
