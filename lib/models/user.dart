import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myfile_app/models/library.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  num? id;
  String? username;
  String? token;
  List<Library>? librarys;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
