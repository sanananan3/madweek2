import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserData {
  final int id;
  final String? userId;
  final String? userPw;
  final String? kakaoId;
  final String token;
  final String name;
  final String call;
  final String birth;
  final DateTime date;

  const UserData({
    required this.id,
    required this.token,
    required this.name,
    required this.call,
    required this.birth,
    required this.date,
    this.userId,
    this.userPw,
    this.kakaoId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
