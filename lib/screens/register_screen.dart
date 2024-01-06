import 'package:flutter/material.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 0;

  String _id = '';
  String _pw = '';

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('회원가입'),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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

                      if (value != _pw) {
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
                            setState(() => _currentIndex = 1);
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
          canPop: _currentIndex != 1,
          onPopInvoked: (didPop) {
            if (!didPop) setState(() => _currentIndex = 0);
          },
          child: AdditionalRegisterScreen(
            type: RegisterType.normal,
            data: {'user_id': _id, 'user_pw': _pw},
            onPrevPressed: () => setState(() => _currentIndex = 0),
          ),
        ),
      ],
    );
  }
}
