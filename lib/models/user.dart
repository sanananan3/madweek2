import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int id;
  final String? userId;
  final String? userPw;
  final int? kakaoId;
  final String token;
  final String name;
  final String phone;
  final DateTime birthDate;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.token,
    required this.name,
    required this.phone,
    required this.birthDate,
    required this.createdAt,
    this.userId,
    this.userPw,
    this.kakaoId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
