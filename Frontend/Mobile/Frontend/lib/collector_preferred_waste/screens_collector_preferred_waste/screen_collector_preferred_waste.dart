import 'package:flutter/material.dart';
import '../widgets_collector_preferred_waste/electronic.dart';
import '../widgets_collector_preferred_waste/metal.dart';
import '../widgets_collector_preferred_waste/plastic.dart';
import '../widgets_collector_preferred_waste/wood.dart';
import '../widgets_collector_preferred_waste/glass.dart';
import '../widgets_collector_preferred_waste/organic.dart';
import '../widgets_collector_preferred_waste/continue.dart';
import '../../collector_acc_pwd/screens_acc_pwd/screen_acc_pwd.dart';

class ScreenCollectorPreferredWaste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preferred Waste Types')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElectronicWaste(),
            MetalWaste(),
            PlasticWaste(),
            WoodWaste(),
            GlassWaste(),
            OrganicWaste(),
            SizedBox(height: 20),
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
      ),
    );
  }
}
