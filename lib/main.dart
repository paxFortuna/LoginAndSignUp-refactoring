import 'package:flutter/material.dart';
import 'package:login_signup_refactoring/init_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'), // English
        Locale('KR'), // Spanish
        Locale('en'), // Spanish
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitPageView(),
    );
  }
}
