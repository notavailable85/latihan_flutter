import 'package:dio/dio.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_14/models/anime_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://api.jikan.moe')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/v4/anime')
  Future<AnimeModels> getAllPosts();
}
