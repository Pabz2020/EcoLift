import 'package:flutter/material.dart';

class ConfirmLocationButton extends StatelessWidget {
  final VoidCallback onConfirmLocationPressed;

  ConfirmLocationButton({required this.onConfirmLocationPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onConfirmLocationPressed,
      child: Text('Confirm Location'),
    );
  }
}
