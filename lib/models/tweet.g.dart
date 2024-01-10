// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TweetImpl _$$TweetImplFromJson(Map<String, dynamic> json) => _$TweetImpl(
      id: json['id'] as int,
      content: json['content'] as String,
      userId: json['user_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TweetImplToJson(_$TweetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };
