import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) =>
      _RestClient(dio, baseUrl: dotenv.env['SERVER_BASEURL']);

  @POST('/register')
  Future<UserResponse> createUser(@Body() UserRequestBody data);

  @POST('/register/kakao')
  Future<UserResponse> createUserByKakao(@Body() UserRequestBody data);

  @POST('/login')
  Future<UserResponse> getUserById(@Body() UserRequestBody data);

  @POST('/verify')
  Future<UserResponse> getUserByToken(@Body() UserRequestBody data);

  @GET('/tweet')
  Future<TweetsResponse> getTweets();

  @GET('/tweet/my')
  Future<TweetsResponse> getMyTweets();

  @POST('/tweet')
  Future<TweetsResponse> writeTweet(@Body() TweetRequestBody data);

  @PATCH('/tweet')
  Future<TweetsResponse> editTweet(@Body() TweetRequestBody data);

  @DELETE('/tweet')
  Future<TweetsResponse> deleteTweet(@Body() TweetRequestBody data);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRequestBody {
  final String? userId;
  final String? userPw;
  final int? kakaoId;
  final String? token;
  final String? name;
  final String? phone;
  final String? birthDate;

  const UserRequestBody({
    this.userId,
    this.userPw,
    this.kakaoId,
    this.token,
    this.name,
    this.phone,
    this.birthDate,
  });

  factory UserRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UserRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestBodyToJson(this);
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
class TweetRequestBody {
  final int? id;
  final String? content;

  const TweetRequestBody({this.id, this.content});

  factory TweetRequestBody.fromJson(Map<String, dynamic> json) =>
      _$TweetRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TweetRequestBodyToJson(this);
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
