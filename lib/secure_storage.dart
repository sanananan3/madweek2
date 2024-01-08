import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage instance = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<String?> readToken() => instance.read(key: 'token');

  static Future<void> writeToken(String token) =>
      instance.write(key: 'token', value: token);
}
