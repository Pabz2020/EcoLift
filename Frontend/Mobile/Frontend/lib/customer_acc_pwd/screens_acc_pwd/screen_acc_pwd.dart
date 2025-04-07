/*import 'package:flutter/material.dart';
import '../widgets_acc_pwd/enter_pwd.dart';
import '../widgets_acc_pwd/confirm_pwd.dart';
import '../widgets_acc_pwd/continue_button.dart';
import '../../customer_reg_end/screens_reg_end/screen_reg_end.dart';

class ScreenAccPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Password')),
      body: Column(
        children: [
          EnterPwd(),
          ConfirmPwd(),
          ContinueButton(onContinueButtonPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenRegEnd()),
            );
          }),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../customer_reg_end/screens_reg_end/screen_reg_end.dart';

class ScreenAccPwd extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String addressNo;
  final String street;
  final String city;
  final String district;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ScreenAccPwd({
    required this.name,
    required this.phone,
    required this.email,
    required this.addressNo,
    required this.street,
    required this.city,
    required this.district,
  });

  Future<void> _submitData(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      await ApiService.registerUser(
        name: name,
        phone: phone,
        email: email,
        addressNo: addressNo,
        street: street,
        city: city,
        district: district,
        password: passwordController.text,
        role: 'customer',
      );

      // If registration is successful, navigate to the success screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenRegEnd()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Enter Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitData(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
