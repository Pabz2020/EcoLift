import 'package:flutter/material.dart';
import '../widgets_collector_details/collector_name.dart';
import '../widgets_collector_details/collector_mail.dart';
import '../widgets_collector_details/phone_no_verification.dart';
import '../../collector_pn_verification/screens_collector_pn_verification/screen_collector_pn_verification.dart';

class ScreenCollectorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Collector Registration')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CollectorName(),
              SizedBox(height: 16),
              CollectorMail(),
              SizedBox(height: 16),
              PhoneNoVerification(
                onVerifyPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenCollectorPnVerification()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
