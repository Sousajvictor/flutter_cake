import 'package:flutter/material.dart';
import 'package:projeto_bolo/screens/home/home_page.dart';
import 'package:projeto_bolo/screens/home/tabs_page.dart';
import 'package:projeto_bolo/screens/home/watch_page.dart';
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
      home: WatchPage(),
    );
  }
}


