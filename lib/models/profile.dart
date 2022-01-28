import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cache_config.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  User? user;
  List? folders;
  CacheConfig? cacheConfig;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}