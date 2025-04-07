/*import 'package:flutter/material.dart';
import '../widgets_customer_address/address_no.dart';
import '../widgets_customer_address/street.dart';
import '../widgets_customer_address/city.dart';
import '../widgets_customer_address/district.dart';
import '../widgets_customer_address/set_location_map.dart';
import '../widgets_customer_address/continue.dart';
import '../../customer_map_location/screens_map_location/screen_map_location.dart';
import '../../customer_acc_pwd/screens_acc_pwd/screen_acc_pwd.dart ';

class ScreenCustomerAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Address')),
      body: Column(
        children: [
          AddressNo(),
          Street(),
          City(),
          District(),
          SetLocationMap(
            onSetLocationPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenMapLocation()),
              );
              // Open map for setting location
            },
          ),
          ContinueButton(
            onContinuePressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenAccPwd()),
              );
            },
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../../customer_acc_pwd/screens_acc_pwd/screen_acc_pwd.dart';

class ScreenCustomerAddress extends StatelessWidget {
  final String name;
  final String phone;
  final String email;

  final TextEditingController addressNoController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  ScreenCustomerAddress({
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Address')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addressNoController,
              decoration: InputDecoration(labelText: 'Address No'),
            ),
            TextField(
              controller: streetController,
              decoration: InputDecoration(labelText: 'Street'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: districtController,
              decoration: InputDecoration(labelText: 'District'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenAccPwd(
                      name: name,
                      phone: phone,
                      email: email,
                      addressNo: addressNoController
                          .text, // Updated to match parameter
                      street: streetController.text,
                      city: cityController.text,
                      district: districtController.text,
                    ),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
