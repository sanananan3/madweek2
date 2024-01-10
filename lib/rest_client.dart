import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/tweet_with_user.dart';
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
  Future<TweetsResponse> getTweetsByUserId(@Body() Map<String, dynamic> data);

  @GET('/tweet/new')
  Future<TweetWithUsersResponse> getNewTweets();

  @POST('/tweet')
  Future<TweetResponse> writeTweet(@Body() TweetRequestBody data);

  @PATCH('/tweet')
  Future<TweetResponse> editTweet(@Body() TweetRequestBody data);

  @DELETE('/tweet')
  Future<TweetResponse> deleteTweet(@Body() TweetRequestBody data);
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
class UsersResponse {
  final bool success;
  final List<User>? users;
  final String? error;

  const UsersResponse({required this.success, this.users, this.error});

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

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
class TweetResponse {
  final bool success;
  final Tweet? tweet;
  final String? error;

  const TweetResponse({required this.success, this.tweet, this.error});

  factory TweetResponse.fromJson(Map<String, dynamic> json) =>
      _$TweetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TweetResponseToJson(this);
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

@JsonSerializable(fieldRename: FieldRename.snake)
class TweetWithUsersResponse {
  final bool success;
  final List<TweetWithUser>? tweets;
  final String? error;

  const TweetWithUsersResponse({
    required this.success,
    this.tweets,
    this.error,
  });

  factory TweetWithUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$TweetWithUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TweetWithUsersResponseToJson(this);
}
