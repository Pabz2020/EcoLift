import 'package:flutter/material.dart';
import '../widgets_collector_pn_verification/otp.dart';
import '../widgets_collector_pn_verification/verify_button.dart';
import '../../collector_vehicle/screens_collector_vehicle/screen_collector_vehicle.dart';

class ScreenCollectorPnVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OtpField(),
            SizedBox(height: 16),
            VerifyButton(
              onVerifyPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenCollectorVehicle()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
