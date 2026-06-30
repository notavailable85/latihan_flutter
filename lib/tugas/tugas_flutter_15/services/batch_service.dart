import 'package:dio/dio.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/batches_response.dart';
import 'package:retrofit/retrofit.dart';

part 'batch_service.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class BatchService {
  factory BatchService(Dio dio, {String baseUrl}) = _BatchService;

  @GET('/api/batches')
  Future<BatchesResponse> getBatches(
    @Header('Authorization') String token,
  );
}
