import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';

class RegisterScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final idController = useTextEditingController();
    final pwController = useTextEditingController();

    return IndexedStack(
      index: currentIndex.value,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('회원가입'),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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

                      if (int.tryParse(value) != null) {
                        return '아이디는 문자가 들어가야 합니다.';
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
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '비밀번호 확인',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요.';
                      }

                      if (value.length < 8) {
                        return '8글자 이상 입력해주세요.';
                      }

                      if (value != pwController.text) {
                        return '비밀번호가 일치하지 않습니다.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('취소'),
                      ),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            currentIndex.value = 1;
                          }
                        },
                        child: const Text('다음'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        PopScope(
          canPop: currentIndex.value != 1,
          onPopInvoked: (didPop) {
            if (!didPop) {
              currentIndex.value = 0;
            }
          },
          child: AdditionalRegisterScreen(
            type: RegisterType.normal,
            data: {'user_id': idController.text, 'user_pw': pwController.text},
            onPrevPressed: () => currentIndex.value = 0,
          ),
        ),
      ],
    );
  }
}
