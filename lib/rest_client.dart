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

  @POST('/search')
  Future<UsersResponse> getUsers(@Body() Map<String, dynamic> data);

  @GET('/tweet')
  Future<TweetsResponse> getTweetsByUserId(@Body() UserRequestBody data);

  @GET('/tweet/new')
  Future<TweetsResponse> getNewTweets();

  @POST('/tweet')
  Future<TweetResponse> writeTweet(@Body() TweetRequestBody data);

  @PATCH('/tweet')
  Future<TweetResponse> editTweet(@Body() TweetRequestBody data);

  @DELETE('/tweet')
  Future<TweetResponse> deleteTweet(@Body() TweetRequestBody data);

  @GET('/like')
  Future<TweetsResponse> getLikesByUserId(@Body() UserRequestBody data);

  @POST('/like')
  Future<BaseResponse> doLikeByTweetId(@Body() TweetRequestBody data);

  @DELETE('/like')
  Future<BaseResponse> cancelLikeByTweetId(@Body() TweetRequestBody data);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BaseResponse {
  final bool success;

  const BaseResponse({required this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRequestBody {
  final int? id;
  final String? userId;
  final String? userPw;
  final int? kakaoId;
  final String? token;
  final String? name;
  final String? phone;
  final String? birthDate;

  const UserRequestBody({
    this.id,
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
class UserResponse extends BaseResponse {
  final User? user;
  final String? error;

  const UserResponse({required super.success, this.user, this.error});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UsersResponse extends BaseResponse {
  final List<User>? users;
  final String? error;

  const UsersResponse({required super.success, this.users, this.error});

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
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
class TweetResponse extends BaseResponse {
  final Tweet? tweet;
  final String? error;

  const TweetResponse({required super.success, this.tweet, this.error});

  factory TweetResponse.fromJson(Map<String, dynamic> json) =>
      _$TweetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TweetResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TweetsResponse extends BaseResponse {
  final List<Tweet>? tweets;
  final String? error;

  const TweetsResponse({required super.success, this.tweets, this.error});

  factory TweetsResponse.fromJson(Map<String, dynamic> json) =>
      _$TweetsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TweetsResponseToJson(this);
}
