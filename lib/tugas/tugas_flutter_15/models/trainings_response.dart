import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';

part 'trainings_response.g.dart';

TrainingsResponse trainingsResponseFromJson(String str) =>
    TrainingsResponse.fromJson(json.decode(str));

String trainingsResponseToJson(TrainingsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class TrainingsResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Training>? data;

  TrainingsResponse({this.message, this.data});

  factory TrainingsResponse.fromJson(Map<String, dynamic> json) =>
      _$TrainingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingsResponseToJson(this);
}
