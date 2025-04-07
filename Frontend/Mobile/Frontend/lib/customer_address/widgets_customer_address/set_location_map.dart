import 'package:flutter/material.dart';

class SetLocationMap extends StatelessWidget {
  final VoidCallback onSetLocationPressed;

  SetLocationMap({required this.onSetLocationPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSetLocationPressed,
      // Open map for setting location
      child: Text('Set Location on Map'),
    );
  }
}
