import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';

part 'training_detail_response.g.dart';

TrainingDetailResponse trainingDetailResponseFromJson(String str) =>
    TrainingDetailResponse.fromJson(json.decode(str));

String trainingDetailResponseToJson(TrainingDetailResponse data) => json.encode(data.toJson());

@JsonSerializable()
class TrainingDetailResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Training? data;

  TrainingDetailResponse({this.message, this.data});

  factory TrainingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TrainingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingDetailResponseToJson(this);
}
