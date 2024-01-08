import 'package:json_annotation/json_annotation.dart';

part 'tweet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tweet {
  final int id;
  final String content;
  final int userId;
  final DateTime createdAt;

  const Tweet({
    required this.id,
    required this.content,
    required this.userId,
    required this.createdAt,
  });

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);

  Map<String, dynamic> toJson() => _$TweetToJson(this);
}
