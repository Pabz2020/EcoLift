import 'package:flutter/material.dart';

class ElectronicWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Electronic'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
