import 'package:flutter/material.dart';

class CollectorName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
    );
  }
}
