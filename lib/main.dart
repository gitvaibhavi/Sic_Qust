import 'package:flutter/material.dart';
import 'home_screen.dart';
// ignore: unused_import
import 'screens/home_screen.dart';

void main() {
  runApp(SciQuestApp());
}

class SciQuestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SciQuest',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
