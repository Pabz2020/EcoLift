import 'package:flutter/material.dart';

class OTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Enter OTP'),
      keyboardType: TextInputType.number,
    );
  }
}
