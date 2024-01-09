import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/home_screen.dart';
import 'package:madcamp_week2/screens/login_screen.dart';
import 'package:madcamp_week2/secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);

  await (bool clean) async {
    if (!clean) return;
    await SecureStorage.instance.deleteAll();
  }(false);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildThemeData(),
      home: switch (ref.watch(userNotifierProvider)) {
        AsyncData(:final value) when value != null => const HomeScreen(),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        _ => LoginScreen(),
      },
    );
  }

  ThemeData _buildThemeData() {
    final base = ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        surface: Color(0xFF1F1F1F),
        background: Color(0xFF1F1F1F),
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dialogTheme: const DialogTheme(
        actionsPadding: EdgeInsets.all(8),
      ),
      dividerTheme: const DividerThemeData(color: Colors.white70),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF42A5F5),
        foregroundColor: Colors.white,
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(visualDensity: VisualDensity.compact),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF3A393C),
          foregroundColor: Colors.white,
        ),
      ),
    );

    return base.copyWith(
      iconTheme: base.iconTheme.copyWith(opacity: 0.7),
      textTheme: GoogleFonts.ibmPlexSansKrTextTheme(
        base.textTheme.apply(bodyColor: Colors.white70),
      ),
    );
  }
}
