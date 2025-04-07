import 'package:flutter/material.dart';
import '../widgets_collector_vehicle/vehicle_type.dart';
import '../widgets_collector_vehicle/vehicle_number.dart';
import '../widgets_collector_vehicle/continue_button.dart';
import '../../collector_preferred_waste/screens_collector_preferred_waste/screen_collector_preferred_waste.dart ';

class ScreenCollectorVehicle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            VehicleType(),
            SizedBox(height: 16),
            VehicleNumber(),
            SizedBox(height: 16),
            ContinueButton(
              onContinuePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenCollectorPreferredWaste()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
