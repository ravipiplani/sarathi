import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentUtil {
  static String getValue(String key) {
    String value = DotEnv().env[key];
    return value;
  }
}