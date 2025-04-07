import 'package:flutter/material.dart';

class GlassWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Glass'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
