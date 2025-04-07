import 'package:flutter/material.dart';

class PhoneNoVerification extends StatelessWidget {
  final VoidCallback onVerifyPressed;

  PhoneNoVerification({required this.onVerifyPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              labelText: 'Phone Number', border: OutlineInputBorder()),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16),
        ElevatedButton(
            onPressed: onVerifyPressed, child: Text('Verify Phone Number')),
      ],
    );
  }
}
