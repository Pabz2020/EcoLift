//import 'dart:ffi';

import 'package:flutter/material.dart';

class PhoneNoVerification extends StatelessWidget {
  final VoidCallback onVerifyPNPressed;

  PhoneNoVerification({required this.onVerifyPNPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onVerifyPNPressed,
      // Verification logic here
      // },
      child: Text('Next'),
    );
  }
}
