import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/register')
  Future<UserResponse> createUser(@Body() Map<String, dynamic> data);

  @POST('/register/kakao')
  Future<UserResponse> createUserByKakao(@Body() Map<String, dynamic> data);

  @POST('/login')
  Future<UserResponse> getUserById(@Body() Map<String, dynamic> data);

  @POST('/verify')
  Future<UserResponse> getUserByToken(@Body() Map<String, dynamic> data);

  @POST('/tweet')
  Future<TweetsResponse> getTweets(@Body() Map<String, dynamic> data);

  @POST('/tweet/my')
  Future<TweetsResponse> getMyTweets(@Body() Map<String, dynamic> data);

  @POST('/tweet/write')
  Future<TweetsResponse> writeTweet(@Body() Map<String, dynamic> data);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  final bool success;
  final User? user;
  final String? error;

  const UserResponse({required this.success, this.user, this.error});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TweetsResponse {
  final bool success;
  final List<Tweet>? tweets;
  final String? error;

  const TweetsResponse({required this.success, this.tweets, this.error});

  factory TweetsResponse.fromJson(Map<String, dynamic> json) =>
      _$TweetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TweetsResponseToJson(this);
}

final restClient = RestClient(Dio(), baseUrl: dotenv.env['SERVER_BASEURL']!);
