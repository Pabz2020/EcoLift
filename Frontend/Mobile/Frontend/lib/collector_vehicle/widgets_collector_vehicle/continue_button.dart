import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onContinuePressed;

  ContinueButton({required this.onContinuePressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onContinuePressed,
      child: Text('Continue'),
    );
  }
}
