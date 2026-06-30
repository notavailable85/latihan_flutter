import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/user_model.dart';

part 'batches_response.g.dart';

BatchesResponse batchesResponseFromJson(String str) =>
    BatchesResponse.fromJson(json.decode(str));

String batchesResponseToJson(BatchesResponse data) => json.encode(data.toJson());

@JsonSerializable()
class BatchesResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Batch>? data;

  BatchesResponse({this.message, this.data});

  factory BatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchesResponseToJson(this);
}
