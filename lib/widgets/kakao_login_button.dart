import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KakaoLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const KakaoLoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/kakao-svgrepo-com.svg',
        width: 24,
        height: 24,
      ),
      label: const Text('카카오 로그인'),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFFEE500),
        foregroundColor: Colors.black87,
        fixedSize: const Size.fromWidth(183),
      ),
    );
  }
}
