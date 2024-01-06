import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
                    if (user == null) return;

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
