import 'package:flutter/material.dart';

class ProceedButton extends StatelessWidget {
  final VoidCallback onProceedPressed;

  ProceedButton({required this.onProceedPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onProceedPressed,
      child: Text('Proceed'),
    );
  }
}
