// lib/first_page/screens_firstpage/screen_firstpage.dart

import 'package:flutter/material.dart';
import '../widgets_firstpage/widgets_1_firstpage.dart';
import '../../second_page/screens_secondpage/screen_secondpage.dart';

class FirstPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FirstPageWidget(
          onNextPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPageScreen()),
            );
          },
        ),
      ),
    );
  }
}
