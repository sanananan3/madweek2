import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';
import 'package:madcamp_week2/screens/register_screen.dart';
import 'package:madcamp_week2/widgets/kakao_login_button.dart';

final _messageProvider = StateProvider<String>((ref) => '');

class LoginScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = useTextEditingController();
    final pwController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    controller: idController,
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
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    controller: pwController,
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
                    textInputAction: TextInputAction.done,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      ref.watch(_messageProvider),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final id = idController.text;
                        final pw = pwController.text;

                        ref.read(_messageProvider.notifier).state = await ref
                                .read(userNotifierProvider.notifier)
                                .loginWithIdAndPassword(id, pw) ??
                            '';
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
                      ref.read(_messageProvider.notifier).state = await ref
                              .read(userNotifierProvider.notifier)
                              .loginWithKakao((kakaoUser) async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdditionalRegisterScreen(
                                  type: RegisterType.kakao,
                                  data: {'kakao_id': kakaoUser.id},
                                ),
                              ),
                            );
                          }) ??
                          '';
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
