// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_with_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetWithUser _$TweetWithUserFromJson(Map<String, dynamic> json) =>
    TweetWithUser(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tweet: Tweet.fromJson(json['tweet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TweetWithUserToJson(TweetWithUser instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tweet': instance.tweet,
    };
