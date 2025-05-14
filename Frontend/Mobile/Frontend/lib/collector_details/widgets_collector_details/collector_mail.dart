import 'package:flutter/material.dart';

class CollectorMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Email Address', border: OutlineInputBorder()),
    );
  }
}
