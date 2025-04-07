// lib/role_selection_page/widgets_roleselection/widgets_1_roleselection.dart
import 'package:flutter/material.dart';

class RoleSelectionWidget extends StatelessWidget {
  final VoidCallback onCustomerPressed, onCollectorPressed;

  RoleSelectionWidget(
      {required this.onCustomerPressed, required this.onCollectorPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onCustomerPressed, // () {
          //Navigator.pushNamed(context, '/customerWelcome');
          // },
          child: Text('Customer'),
        ),
        ElevatedButton(
          onPressed: onCollectorPressed,
          // Navigate to Collector Role

          child: Text('Collector'),
        ),
      ],
    );
  }
}
