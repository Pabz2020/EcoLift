import 'package:flutter/material.dart';

class CustomerPhoneNum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
    );
  }
}
