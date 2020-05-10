import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sarathi/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  return runApp(EasyLocalization(
    child: AppRoot(),
    supportedLocales: [
      Locale('en', 'US'),
      Locale('hi', 'IN')
    ],
    path: 'assets/languages'
  ));
}