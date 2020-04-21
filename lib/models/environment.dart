import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getValue(String key) {
    String value = DotEnv().env[key];
    return value;
  }
}