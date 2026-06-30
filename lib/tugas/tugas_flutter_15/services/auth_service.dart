import 'package:dio/dio.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/auth_response.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/models/profile_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @GET('/api/profile')
  Future<ProfileResponse> getProfile(@Header('Authorization') String token);

  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @PUT('/api/profile/photo')
  Future<ProfileResponse> updateProfilePhoto(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );
}
