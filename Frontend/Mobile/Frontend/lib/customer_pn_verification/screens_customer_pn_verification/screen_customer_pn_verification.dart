/*import 'package:flutter/material.dart';
import '../widgets_customer_pn_verification/otp.dart';
import '../widgets_customer_pn_verification/verify_button.dart';
import '../../customer_address/screens_customer_address/screen_customer_address.dart';

class ScreenCustomerPNVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Number Verification')),
      body: Column(
        children: [
          OTP(),
          VerifyButton(onVerifyPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenCustomerAddress()),
            );
          }),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../widgets_customer_pn_verification/otp.dart';
import '../widgets_customer_pn_verification/verify_button.dart';
import '../../customer_address/screens_customer_address/screen_customer_address.dart';

class ScreenCustomerPNVerification extends StatelessWidget {
  final String name;
  final String phone;
  final String email;

  ScreenCustomerPNVerification(
      {required this.name, required this.phone, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Number Verification')),
      body: Column(
        children: [
          OTP(),
          VerifyButton(
            onVerifyPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenCustomerAddress(
                    name: name,
                    phone: phone,
                    email: email,
                  ),
                  settings: RouteSettings(name: '/customer_address'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
