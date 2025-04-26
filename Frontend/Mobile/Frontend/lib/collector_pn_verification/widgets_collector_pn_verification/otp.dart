import 'package:flutter/material.dart';

class OtpField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(labelText: 'Enter OTP', border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
    );
  }
}
