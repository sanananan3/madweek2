import 'package:flutter/material.dart';
import 'package:madcamp_week2/screens/additional_register_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _id = '';
  String _pw = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
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
                onChanged: (value) => setState(() => _id = value),
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
                onChanged: (value) => setState(() => _pw = value),
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
              ),
              FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdditionalRegisterScreen(
                          type: RegisterType.normal,
                          data: {'user_id': _id, 'user_pw': _pw},
                        ),
                      ),
                    );
                  }
                },
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
