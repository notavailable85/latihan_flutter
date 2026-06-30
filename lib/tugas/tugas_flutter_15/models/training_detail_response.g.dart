// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingDetailResponse _$TrainingDetailResponseFromJson(
  Map<String, dynamic> json,
) => TrainingDetailResponse(
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Training.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TrainingDetailResponseToJson(
  TrainingDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};
