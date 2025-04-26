import 'package:flutter/material.dart';
import '../widgets_reg_end/proceed.dart';

class ScreenRegEnd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration Complete')),
      body: Center(
        child: ProceedButton(
          onProceedPressed: () {
            // Navigate to collector dashboard or home
          },
        ),
      ),
    );
  }
}
