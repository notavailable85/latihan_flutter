import 'package:dio/dio.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/trainings_response.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/training_detail_response.dart';
import 'package:retrofit/retrofit.dart';

part 'training_service.g.dart';

@RestApi(baseUrl: 'https://appabsensi.mobileprojp.com')
abstract class TrainingService {
  factory TrainingService(Dio dio, {String baseUrl}) = _TrainingService;

  @GET('/api/trainings')
  Future<TrainingsResponse> getTrainings();

  @GET('/api/trainings/{id}')
  Future<TrainingDetailResponse> getTrainingDetail(
    @Path('id') int id,
    @Header('Authorization') String token,
  );
}
