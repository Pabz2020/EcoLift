import 'package:flutter/material.dart';

class VehicleType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          labelText: 'Vehicle Type', border: OutlineInputBorder()),
      items: [
        'Lorry',
        'Dimo Batta',
        'Tractor',
        'Land Master',
        'Three-Wheeler',
        'Motorcycle'
      ]
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: (value) {},
    );
  }
}
