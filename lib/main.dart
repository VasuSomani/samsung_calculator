import 'package:calculator/Util/HexToColor.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'CalculatorPage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          textTheme:
              const TextTheme(displayMedium: TextStyle(color: Colors.white)),
          brightness: Brightness.dark,
          useMaterial3: true,
          scaffoldBackgroundColor: HexColor("#010101"),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(100, 30, 30, 30)),
                  shape: MaterialStatePropertyAll(CircleBorder())))),
      theme: ThemeData(
          textTheme:
              const TextTheme(displayMedium: TextStyle(color: Colors.black)),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(HexColor("#F9F9F9")),
                  shape: const MaterialStatePropertyAll(CircleBorder())))),
      home: CalculatorPage(),
    );
  }
}
