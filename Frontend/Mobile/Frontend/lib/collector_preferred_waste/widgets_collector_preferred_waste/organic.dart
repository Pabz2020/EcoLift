import 'package:flutter/material.dart';

class OrganicWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Organic'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
