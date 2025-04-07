// lib/first_page/widgets_firstpage/widgets_1_firstpage.dart

import 'package:flutter/material.dart';

class FirstPageWidget extends StatelessWidget {
  final VoidCallback onNextPressed;

  FirstPageWidget({required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to ECO LIFT', style: TextStyle(fontSize: 24)),
        Text('Waste to Wonders'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNextPressed,
          child: Text('Next'),
        ),
      ],
    );
  }
}
