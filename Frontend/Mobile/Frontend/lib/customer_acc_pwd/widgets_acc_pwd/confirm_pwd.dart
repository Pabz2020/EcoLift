import 'package:flutter/material.dart';

class ConfirmPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
    );
  }
}
