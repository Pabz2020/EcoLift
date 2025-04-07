// lib/second_page/screens_secondpage/screen_secondpage.dart
import 'package:flutter/material.dart';
import '../widgets_secondpage/widgets_1_secondpage.dart';
import '../../role_selection/screens_roleselection/screen_roleselection.dart';

class SecondPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SecondPageWidget(
          onContinuePressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoleSelectionPage()),
            );
          },
        ),
      ),
    );
  }
}
