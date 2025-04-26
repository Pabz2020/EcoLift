import 'package:flutter/material.dart';

class EnterPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Enter Password'),
      obscureText: true,
    );
  }
}
