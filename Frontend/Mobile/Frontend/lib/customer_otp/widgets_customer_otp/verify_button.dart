import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final VoidCallback onPressed;

  VerifyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Verify'),
    );
  }
}
