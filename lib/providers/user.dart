import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao
    show User;
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/secure_storage.dart';

class UserNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() async {
    try {
      final token = await SecureStorage.readToken();
      if (token == null || token.isEmpty) return null;

      final response = await restClient.getUserByToken({'token': token});
      return response.user;
    } catch (error) {
      return null;
    }
  }

  Future<String?> loginWithIdAndPassword(String id, String pw) async {
    try {
      final response = await restClient.getUserById(
        {'user_id': id, 'user_pw': pw},
      );

      if (response.success) {
        await SecureStorage.writeToken(response.user!.token);
        state = AsyncData(response.user);
        return null;
      }
    } catch (error) {
      switch (error) {
        case DioException(:final response?):
          final data = response.data as Map<String, dynamic>;
          return data['error'].toString();
      }
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<String?> loginWithKakao(
    FutureOr<void> Function(kakao.User) onRegister,
  ) async {
    final user = await _getKakaoUser();
    if (user == null) {
      return '알 수 없는 오류가 발생했습니다.';
    }

    try {
      final response = await restClient.getUserById({'kakao_id': user.id});

      if (response.success) {
        await SecureStorage.writeToken(response.user!.token);
        state = AsyncData(response.user);
        return null;
      }
    } catch (error) {
      switch (error) {
        case DioException(:final response?) when response.statusCode == 401:
          await onRegister(user);
          return null;
        case DioException(:final response?):
          final data = response.data as Map<String, dynamic>;
          return data['error'].toString();
      }
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<kakao.User?> _getKakaoUser() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (kDebugMode) print(error);

        switch (error) {
          case KakaoAuthException(error: AuthErrorCause.accessDenied):
          case PlatformException(code: 'CANCELED'):
            return null;
        }

        try {
          await UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          if (kDebugMode) print(error);
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        if (kDebugMode) print(error);
      }
    }

    try {
      return await UserApi.instance.me();
    } catch (error) {
      if (kDebugMode) print(error);
    }

    return null;
  }

  Future<String?> registerWithIdAndPassword({
    required String userId,
    required String userPw,
    required String name,
    required String phone,
    required String birthDate,
  }) async {
    try {
      final response = await restClient.createUser({
        'user_id': userId,
        'user_pw': userPw,
        'name': name,
        'phone': phone,
        'birth_date': birthDate,
      });

      if (response.success) {
        await SecureStorage.writeToken(response.user!.token);
        state = AsyncData(response.user);
        return null;
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<String?> registerWithKakao({
    required int kakaoId,
    required String name,
    required String phone,
    required String birthDate,
  }) async {
    try {
      final response = await restClient.createUserByKakao({
        'kakao_id': kakaoId,
        'name': name,
        'phone': phone,
        'birth_date': birthDate,
      });

      if (response.success) {
        await SecureStorage.writeToken(response.user!.token);
        state = AsyncData(response.user);
        return null;
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<void> logout() async {
    if (!state.hasValue || state.value == null) return;
    await SecureStorage.deleteToken();
    state = const AsyncData(null);
  }


}

final userNotifierProvider =
    AsyncNotifierProvider<UserNotifier, User?>(UserNotifier.new);
