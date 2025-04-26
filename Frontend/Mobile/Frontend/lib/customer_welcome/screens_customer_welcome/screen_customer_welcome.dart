/*import 'package:flutter/material.dart';
import '../widgets_customer_welcome/customer_name.dart';
import '../widgets_customer_welcome/customer_phone_num.dart';
import '../widgets_customer_welcome/customer_mail.dart';
import '../widgets_customer_welcome/phone_no_verification.dart';
//import '../../customer_pn_verification/screens_customer_pn_verification/screen_customer_pn_verification.dart';
import '../../customer_address/screens_customer_address/screen_customer_address.dart';

class CustomerWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomerName(),
            CustomerPhoneNum(),
            CustomerMail(),
            PhoneNoVerification(
              onVerifyPNPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenCustomerAddress()) // ScreenCustomerPNVerification},
                    );
              },
            ),

            //ElevatedButton(
            // onPressed: () {
            // Navigator.pushNamed(context, '/customerPnVerification');
            //},
            //child: Text('Phone Number Verification'),
            // ),

            // back button
            //ElevatedButton(
            //onPressed: () {
            // Navigator.pop(context);
            //  },
            //  child: Text('Back'),
            // ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../widgets_customer_welcome/customer_name.dart';
import '../widgets_customer_welcome/customer_phone_num.dart';
import '../widgets_customer_welcome/customer_mail.dart';
import '../widgets_customer_welcome/phone_no_verification.dart';
import '../../customer_address/screens_customer_address/screen_customer_address.dart';

class CustomerWelcomePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Welcome')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenCustomerAddress(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
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
