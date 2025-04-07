import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onContinueButtonPressed;

  ContinueButton({required this.onContinueButtonPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onContinueButtonPressed,
      child: Text('Continue'),
    );
  }
}
