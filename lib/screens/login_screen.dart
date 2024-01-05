import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';
import 'package:madcamp_week2/screens/register_screen.dart';
import 'package:madcamp_week2/widgets/kakao_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
