import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<String?> readToken() => secureStorage.read(key: 'token');

  static Future<void> writeToken(String token) =>
      secureStorage.write(key: 'token', value: token);
}

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);
