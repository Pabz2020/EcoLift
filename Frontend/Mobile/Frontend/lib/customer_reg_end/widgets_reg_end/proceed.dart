import 'package:flutter/material.dart';

class ProceedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Proceed to the next step or dashboard
      },
      child: Text('Proceed'),
    );
  }
}
