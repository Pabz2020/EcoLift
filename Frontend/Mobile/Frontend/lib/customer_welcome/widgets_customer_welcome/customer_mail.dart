import 'package:flutter/material.dart';

class CustomerMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'E-mail Address'),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
