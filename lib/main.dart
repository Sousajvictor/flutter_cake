import 'package:flutter/material.dart';
import 'package:projeto_bolo/screens/home/home_page.dart';
import 'core/theme.dart';

//import 'screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: HomePage(title: 'C O N F E I T A R I A'),
    );
  }
}


