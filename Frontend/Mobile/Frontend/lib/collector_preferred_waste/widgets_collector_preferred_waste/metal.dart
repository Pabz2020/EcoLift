import 'package:flutter/material.dart';

class MetalWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Metal'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
