import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/user.dart';

enum RegisterType {
  normal,
  kakao,
}

class AdditionalRegisterScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final RegisterType type;
  final Map<String, dynamic> data;
  final VoidCallback? onPrevPressed;

  AdditionalRegisterScreen({
    required this.type,
    required this.data,
    this.onPrevPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final birthDateController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('추가 정보 기입'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
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
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: phoneController,
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
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: birthDateController,
                decoration: const InputDecoration(
                  labelText: '생년월일',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '생년월일을 입력해주세요.';
                  }

                  if (value.length != 8) {
                    return '생년월일은 8글자여야 합니다.';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onPrevPressed != null)
                    FilledButton(
                      onPressed: onPrevPressed,
                      child: const Text('이전'),
                    ),
                  FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final error = switch (type) {
                          RegisterType.normal => await ref
                              .read(userNotifierProvider.notifier)
                              .registerWithIdAndPassword(
                                userId: data['user_id'].toString(),
                                userPw: data['user_pw'].toString(),
                                name: nameController.text,
                                phone: phoneController.text,
                                birthDate: birthDateController.text,
                              ),
                          RegisterType.kakao => await ref
                              .read(userNotifierProvider.notifier)
                              .registerWithKakao(
                                kakaoId: data['kakao_id'] as int,
                                name: nameController.text,
                                phone: phoneController.text,
                                birthDate: birthDateController.text,
                              ),
                        };

                        if (!context.mounted) return;

                        if (error == null) {
                          Navigator.pop(context);
                          return;
                        }

                        await showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('오류'),
                            content: Text(error),
                          ),
                        );
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
}
