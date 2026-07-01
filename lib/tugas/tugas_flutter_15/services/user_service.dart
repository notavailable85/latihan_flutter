import 'package:dio/dio.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/users_response.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: 'https://appabsensi.mobileprojp.com')
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET('/api/users')
  Future<UsersResponse> getUsers();
}
