// lib/main.dart
import 'package:flutter/material.dart';
import 'first_page/screens_firstpage/screen_firstpage.dart';

void main() {
  runApp(EcoLiftApp());
}

class EcoLiftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Lift',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstPageScreen(),
    );
  }
}
