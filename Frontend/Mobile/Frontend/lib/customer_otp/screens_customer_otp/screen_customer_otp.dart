import 'package:flutter/material.dart';
import '../widgets_customer_otp/otp.dart';
import '../widgets_customer_otp/verify_button.dart';
import '../widgets_customer_otp/key_pad.dart';

class ScreenCustomerOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Column(
        children: [
          OTP(),
          KeyPad(),
          VerifyButton(onPressed: () {
            // Verification logic
          }),
        ],
      ),
    );
  }
}
