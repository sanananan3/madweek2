import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:madcamp_week2/main.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';
import 'package:madcamp_week2/screens/register_screen.dart';
import 'package:madcamp_week2/widgets/kakao_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _message = '';

  String _id = '';
  String _pw = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MadCamp Week2',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '아이디',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력해주세요.';
                    }

                    if (value.length < 5) {
                      return '5글자 이상 입력해주세요.';
                    }
                    return null;
                  },
                  onChanged: (value) => _id = value,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }

                    if (value.length < 8) {
                      return '8글자 이상 입력해주세요.';
                    }
                    return null;
                  },
                  onChanged: (value) => _pw = value,
                  textInputAction: TextInputAction.done,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    _message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final response = await restClient.getUser(
                          {'user_id': _id, 'user_pw': _pw},
                        );

                        if (!context.mounted) return;

                        await Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(user: response.user!),
                          ),
                          (route) => false,
                        );
                      } catch (error) {
                        switch (error) {
                          case DioException(:final response?)
                              when response.statusCode == 401:
                            setState(() => _message = '아이디 또는 비밀번호가 잘못되었습니다.');
                          default:
                            setState(() => _message = '알 수 없는 오류가 발생했습니다.');
                        }
                      }
                    }
                  },
                  style: FilledButton.styleFrom(
                    fixedSize: const Size.fromWidth(183),
                  ),
                  child: const Text('로그인'),
                ),
                const Divider(),
                FilledButton(
                  onPressed: () async {
                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    fixedSize: const Size.fromWidth(183),
                  ),
                  child: const Text('회원가입'),
                ),
                KakaoLoginButton(
                  onPressed: () async {
                    final user = await _loginWithKakaoTalk();
                    if (user == null) {
                      setState(() => _message = '알 수 없는 오류가 발생했습니다.');
                      return;
                    }

                    try {
                      final response = await restClient.getUser(
                        {'kakao_id': user.id},
                      );

                      if (!context.mounted) return;

                      await Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(user: response.user!),
                        ),
                        (route) => false,
                      );
                    } catch (error) {
                      switch (error) {
                        case DioException(:final response?)
                            when response.statusCode == 401:
                          if (!context.mounted) return;

                          await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdditionalRegisterScreen(
                                type: RegisterType.kakao,
                                data: {'kakao_id': user.id},
                              ),
                            ),
                          );
                        default:
                          setState(() => _message = '알 수 없는 오류가 발생했습니다.');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User?> _loginWithKakaoTalk() async {
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
      final user = await UserApi.instance.me();
      await UserApi.instance.unlink();
      return user;
    } catch (error) {
      if (kDebugMode) print(error);
    }

    return null;
  }
}
