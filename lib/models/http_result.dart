import 'package:json_annotation/json_annotation.dart';

part 'http_result.g.dart';

@JsonSerializable()
class HttpResult {
  HttpResult();

  num? code;
  String? message;
  Map<String,dynamic>? data;
  
  factory HttpResult.fromJson(Map<String,dynamic> json) => _$HttpResultFromJson(json);
  Map<String, dynamic> toJson() => _$HttpResultToJson(this);
}