import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nymble_pet_app/constants.dart';
import 'package:nymble_pet_app/screens/splash.dart';
import 'package:nymble_pet_app/ui/app_theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(petBoxKey);
  await Hive.openBox(appBoxKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appThemeData[AppTheme.LightTheme],
      darkTheme: appThemeData[AppTheme.DarkTheme],
      themeMode: ThemeMode.system,
      home: const Splash(),
    );
  }
}
