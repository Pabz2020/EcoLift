import 'package:flutter/material.dart';

class VehicleNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Vehicle Number', border: OutlineInputBorder()),
    );
  }
}
