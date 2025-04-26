// lib/second_page/widgets_secondpage/widgets_1_secondpage.dart
import 'package:flutter/material.dart';

class SecondPageWidget extends StatelessWidget {
  final VoidCallback onContinuePressed;

  SecondPageWidget({required this.onContinuePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Turn your waste into worth.'),
        Text('Join us to recycle smarter and keep the environment cleaner!'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onContinuePressed,
          child: Text('Continue'),
        ),
      ],
    );
  }
}
