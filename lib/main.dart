import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:madcamp_week2/models/user_data.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:madcamp_week2/screens/home_screen.dart';
import 'package:madcamp_week2/screens/login_screen.dart';
import 'package:madcamp_week2/secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);

  //await secureStorage.deleteAll();
  final token = await SecureStorage.readToken();

  UserData? user;

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
  final UserData? user;

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
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: base.colorScheme.inversePrimary,
      ),
      textTheme: GoogleFonts.ibmPlexSansKrTextTheme(
        base.textTheme.apply(bodyColor: Colors.black87),
      ),
    );
  }
}
