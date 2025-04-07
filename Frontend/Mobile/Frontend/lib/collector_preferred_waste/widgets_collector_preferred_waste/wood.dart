import 'package:flutter/material.dart';

class WoodWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Wood'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
