import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await storage.write(key: "auth_token", value: token);
  }

  static Future<String?> readToken() async {
    return await storage.read(key: "auth_token");
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: "auth_token");
  }
}
