import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final VoidCallback onVerifyPressed;

  VerifyButton({required this.onVerifyPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onVerifyPressed,
      child: Text('Verify'),
    );
  }
}
