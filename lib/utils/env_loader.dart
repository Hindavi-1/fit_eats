import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static Future<void> load() async {
    try {
      // Web build loads from assets, mobile loads from root
      if (kIsWeb) {
        await dotenv.load(fileName: ".env");
      } else {
        await dotenv.load(fileName: ".env");
      }
    } catch (e) {
      debugPrint("⚠️ Failed to load .env file: $e");
    }
  }

  static String? get(String key) {
    return dotenv.env[key];
  }
}
