// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      token: json['token'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String?,
      userPw: json['user_pw'] as String?,
      kakaoId: json['kakao_id'] as int?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_pw': instance.userPw,
      'kakao_id': instance.kakaoId,
      'token': instance.token,
      'name': instance.name,
      'phone': instance.phone,
      'birth_date': instance.birthDate.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
