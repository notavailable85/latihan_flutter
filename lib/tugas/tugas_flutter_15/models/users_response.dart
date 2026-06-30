import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';

part 'users_response.g.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

@JsonSerializable()
class UsersResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<User>? data;

  UsersResponse({this.message, this.data});

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
