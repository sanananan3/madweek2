import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);
}
