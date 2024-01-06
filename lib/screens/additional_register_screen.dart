import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week2/main.dart';
import 'package:madcamp_week2/models/user_data.dart';

enum RegisterType {
  normal,
  kakao,
}

class AdditionalRegisterScreen extends StatefulWidget {
  final RegisterType type;
  final Map<String, dynamic> data;

  const AdditionalRegisterScreen({
    required this.type,
    required this.data,
    super.key,
  });

  @override
  State<AdditionalRegisterScreen> createState() =>
      _AdditionalRegisterScreenState();
}

class _AdditionalRegisterScreenState extends State<AdditionalRegisterScreen> {
  final _dio = Dio(
    BaseOptions(baseUrl: 'http://143.248.225.35:8000'),
  );

  final _formKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  String _name = '';
  String _call = '';
  String _birth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추가 정보 기입'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력해주세요.';
                  }

                  if (value.length < 3) {
                    return '3글자 이상 입력해주세요.';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _name = value),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 입력해주세요.';
                  }

                  if (value.length != 11) {
                    return '전화번호는 11글자여야 합니다.';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _call = value),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '생년월일',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생년월일을 입력해주세요.';
                  }

                  if (value.length != 6) {
                    return '생년월일은 6글자여야 합니다.';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _birth = value),
                textInputAction: TextInputAction.done,
              ),
              FilledButton(
                onPressed: _isProcessing
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _register().then(
                            (_) => setState(() => _isProcessing = false),
                          );
                          setState(() => _isProcessing = true);
                        }
                      },
                child: const Text('회원가입 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    late Response<Map<String, dynamic>> response;

    switch (widget.type) {
      case RegisterType.normal:
        response = await _dio.post<Map<String, dynamic>>(
          '/register',
          data: {
            'user_id': widget.data['user_id'],
            'user_pw': widget.data['user_pw'],
            'name': _name,
            'call': _call,
            'birth': _birth,
          },
        );
      case RegisterType.kakao:
        response = await _dio.post<Map<String, dynamic>>(
          '/kakaoregister',
          data: {
            'kakao_id': widget.data['kakao_id'],
            'name': _name,
            'call': _call,
            'birth': _birth,
          },
        );
    }

    if (response.data == null) return;
    if (!(response.data!['success'] as bool)) return;

    final user =
        UserData.fromJson(response.data!['user'] as Map<String, dynamic>);

    if (!context.mounted) return;

    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(user: user)),
      (route) => false,
    );
  }
}
