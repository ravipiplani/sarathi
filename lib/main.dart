import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yathaarth/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  return runApp(AppRoot());
}