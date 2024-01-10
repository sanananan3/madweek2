import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madcamp_week2/models/user.dart';

part 'tweet.freezed.dart';

part 'tweet.g.dart';

@freezed
class Tweet with _$Tweet {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Tweet({
    required int id,
    required String content,
    required int userId,
    required DateTime createdAt,
    User? user,
    bool? like,
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);
}
