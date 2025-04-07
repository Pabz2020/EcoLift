// lib/role_selection_page/screens_roleselection/screen_roleselection.dart

import 'package:flutter/material.dart';
import '../widgets_roleselection/widgets_1_roleselection.dart';
import '../../customer_welcome/screens_customer_welcome/screen_customer_welcome.dart';
import '../../collector_details/screens_collector_details/screen_collector_details.dart';

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Role Selection')),
      body: Center(
        child: RoleSelectionWidget(
          onCustomerPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomerWelcomePage()),
            );
          },

          onCollectorPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenCollectorDetails()),
            );
            // Navigate to Collector Role
          },
          // child: Text('Customer'),
        ),
      ),
    );
  }
}
