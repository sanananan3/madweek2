import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:madcamp_week2/models/user_data.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) =>
      _RestClient(dio, baseUrl: dotenv.env['SERVER_BASEURL']);

  @POST('/register')
  Future<UserResponse> createUser(@Body() Map<String, dynamic> data);

  @POST('/kakaoregister')
  Future<UserResponse> createUserByKakao(@Body() Map<String, dynamic> data);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  final bool? success;
  final UserData? user;
  final String? error;

  const UserResponse({this.success, this.user, this.error});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
