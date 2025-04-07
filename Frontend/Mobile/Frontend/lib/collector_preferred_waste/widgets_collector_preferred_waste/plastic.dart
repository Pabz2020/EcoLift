import 'package:flutter/material.dart';

class PlasticWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Plastic'),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
