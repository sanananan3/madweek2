// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tweet _$TweetFromJson(Map<String, dynamic> json) {
  return _Tweet.fromJson(json);
}

/// @nodoc
mixin _$Tweet {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  bool? get like => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TweetCopyWith<Tweet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetCopyWith<$Res> {
  factory $TweetCopyWith(Tweet value, $Res Function(Tweet) then) =
      _$TweetCopyWithImpl<$Res, Tweet>;
  @useResult
  $Res call(
      {int id,
      String content,
      int userId,
      DateTime createdAt,
      User? user,
      bool? like});
}

/// @nodoc
class _$TweetCopyWithImpl<$Res, $Val extends Tweet>
    implements $TweetCopyWith<$Res> {
  _$TweetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? user = freezed,
    Object? like = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TweetImplCopyWith<$Res> implements $TweetCopyWith<$Res> {
  factory _$$TweetImplCopyWith(
          _$TweetImpl value, $Res Function(_$TweetImpl) then) =
      __$$TweetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String content,
      int userId,
      DateTime createdAt,
      User? user,
      bool? like});
}

/// @nodoc
class __$$TweetImplCopyWithImpl<$Res>
    extends _$TweetCopyWithImpl<$Res, _$TweetImpl>
    implements _$$TweetImplCopyWith<$Res> {
  __$$TweetImplCopyWithImpl(
      _$TweetImpl _value, $Res Function(_$TweetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? user = freezed,
    Object? like = freezed,
  }) {
    return _then(_$TweetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TweetImpl implements _Tweet {
  const _$TweetImpl(
      {required this.id,
      required this.content,
      required this.userId,
      required this.createdAt,
      this.user,
      this.like});

  factory _$TweetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TweetImplFromJson(json);

  @override
  final int id;
  @override
  final String content;
  @override
  final int userId;
  @override
  final DateTime createdAt;
  @override
  final User? user;
  @override
  final bool? like;

  @override
  String toString() {
    return 'Tweet(id: $id, content: $content, userId: $userId, createdAt: $createdAt, user: $user, like: $like)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TweetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.like, like) || other.like == like));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, userId, createdAt, user, like);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TweetImplCopyWith<_$TweetImpl> get copyWith =>
      __$$TweetImplCopyWithImpl<_$TweetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TweetImplToJson(
      this,
    );
  }
}

abstract class _Tweet implements Tweet {
  const factory _Tweet(
      {required final int id,
      required final String content,
      required final int userId,
      required final DateTime createdAt,
      final User? user,
      final bool? like}) = _$TweetImpl;

  factory _Tweet.fromJson(Map<String, dynamic> json) = _$TweetImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  int get userId;
  @override
  DateTime get createdAt;
  @override
  User? get user;
  @override
  bool? get like;
  @override
  @JsonKey(ignore: true)
  _$$TweetImplCopyWith<_$TweetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
