import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao
    show User;
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/providers/rest_client.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/secure_storage.dart';

class UserNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() async {
    try {
      final token = await SecureStorage.readToken();
      if (token == null || token.isEmpty) return null;

      final restClient = ref.read(restClientProvider);
      final response =
          await restClient.getUserByToken(UserRequestBody(token: token));
      return response.user;
    } catch (error) {
      return null;
    }
  }

  Future<String?> loginWithIdAndPassword(String id, String pw) async {
    try {
      final restClient = ref.read(restClientProvider);
      final response =
          await restClient.getUserById(UserRequestBody(userId: id, userPw: pw));

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

  Future<String?> loginWithKakao(void Function(kakao.User) onRegister) async {
    final user = await _getKakaoUser();
    if (user == null) {
      return '알 수 없는 오류가 발생했습니다.';
    }

    try {
      final restClient = ref.read(restClientProvider);
      final response =
          await restClient.getUserById(UserRequestBody(kakaoId: user.id));

      if (response.success) {
        await SecureStorage.writeToken(response.user!.token);
        state = AsyncData(response.user);
        return null;
      }
    } catch (error) {
      switch (error) {
        case DioException(:final response?) when response.statusCode == 401:
          onRegister(user);
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
      final restClient = ref.read(restClientProvider);
      final response = await restClient.createUser(
        UserRequestBody(
          userId: userId,
          userPw: userPw,
          name: name,
          phone: phone,
          birthDate: birthDate,
        ),
      );

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
      final restClient = ref.read(restClientProvider);
      final response = await restClient.createUserByKakao(
        UserRequestBody(
          kakaoId: kakaoId,
          name: name,
          phone: phone,
          birthDate: birthDate,
        ),
      );

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
