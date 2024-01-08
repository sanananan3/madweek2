import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/screens/home_screen.dart';
import 'package:madcamp_week2/screens/login_screen.dart';
import 'package:madcamp_week2/secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);

  //await SecureStorage.instance.deleteAll();
  final token = await SecureStorage.readToken();

  User? user;

  if (token != null && token.isNotEmpty) {
    try {
      final response = await restClient.getUserByToken({'token': token});
      user = response.user;
    } catch (error) {
      user = null;
    }
  }

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildThemeData(),
      home: user == null ? const LoginScreen() : HomeScreen(user: user!),
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
