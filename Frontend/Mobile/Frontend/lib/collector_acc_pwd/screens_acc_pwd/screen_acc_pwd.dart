import 'package:flutter/material.dart';
import '../widgets_acc_pwd/enter_pwd.dart';
import '../widgets_acc_pwd/confirm_pwd.dart';
import '../widgets_acc_pwd/continue_button.dart';
import '../../collector_reg_end/screens_reg_end/screen_reg_end.dart';

class ScreenAccPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EnterPwd(),
            SizedBox(height: 16),
            ConfirmPwd(),
            SizedBox(height: 16),
            ContinueButton(
              onContinuePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenRegEnd()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
