import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/screens/home_screen.dart';
import 'package:madcamp_week2/secure_storage.dart';

enum RegisterType {
  normal,
  kakao,
}

class AdditionalRegisterScreen extends StatefulWidget {
  final RegisterType type;
  final Map<String, dynamic> data;
  final VoidCallback? onPrevPressed;

  const AdditionalRegisterScreen({
    required this.type,
    required this.data,
    this.onPrevPressed,
    super.key,
  });

  @override
  State<AdditionalRegisterScreen> createState() =>
      _AdditionalRegisterScreenState();
}

class _AdditionalRegisterScreenState extends State<AdditionalRegisterScreen> {
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
        automaticallyImplyLeading: false,
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
                onChanged: (value) => _name = value,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 입력해주세요.';
                  }

                  if (value.length != 11) {
                    return '전화번호는 11글자여야 합니다.';
                  }
                  return null;
                },
                onChanged: (value) => _call = value,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '생년월일',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생년월일을 입력해주세요.';
                  }

                  if (value.length != 6) {
                    return '생년월일은 6글자여야 합니다.';
                  }
                  return null;
                },
                onChanged: (value) => _birth = value,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.onPrevPressed != null)
                    FilledButton(
                      onPressed: widget.onPrevPressed,
                      child: const Text('이전'),
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
                    child: const Text('완료'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    late UserResponse response;

    try {
      switch (widget.type) {
        case RegisterType.normal:
          response = await restClient.createUser({
            'user_id': widget.data['user_id'],
            'user_pw': widget.data['user_pw'],
            'name': _name,
            'call': _call,
            'birth': _birth,
          });
        case RegisterType.kakao:
          response = await restClient.createUserByKakao({
            'kakao_id': widget.data['kakao_id'],
            'name': _name,
            'call': _call,
            'birth': _birth,
          });
      }
    } on DioException catch (error) {
      if (!context.mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('오류'),
          content: Text(error.message!),
        ),
      );
    }

    if (response.success) {
      final userData = response.user!;

      await SecureStorage.writeToken(userData.token);

      if (!context.mounted) return;

      await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(user: userData)),
        (route) => false,
      );
    }
  }
}
