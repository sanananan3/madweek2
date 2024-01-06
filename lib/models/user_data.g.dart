// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      token: json['token'] as String,
      name: json['name'] as String,
      call: json['call'] as String,
      birth: json['birth'] as String,
      date: DateTime.parse(json['date'] as String),
      userId: json['user_id'] as String?,
      userPw: json['user_pw'] as String?,
      kakaoId: json['kakao_id'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_pw': instance.userPw,
      'kakao_id': instance.kakaoId,
      'token': instance.token,
      'name': instance.name,
      'call': instance.call,
      'birth': instance.birth,
      'date': instance.date.toIso8601String(),
    };
