import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/user.dart';

part 'tweet_with_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TweetWithUser {
  final User user;
  final Tweet tweet;

  const TweetWithUser({required this.user, required this.tweet});

  factory TweetWithUser.fromJson(Map<String, dynamic> json) =>
      _$TweetWithUserFromJson(json);

  Map<String, dynamic> toJson() => _$TweetWithUserToJson(this);
}
