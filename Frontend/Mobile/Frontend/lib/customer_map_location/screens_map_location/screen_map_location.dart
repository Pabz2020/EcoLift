/*import 'package:flutter/material.dart';
import '../widgets_map_location/google_map.dart';
import '../widgets_map_location/confirm_location.dart';
import '../../customer_acc_pwd/screens_acc_pwd/screen_acc_pwd.dart ';

class ScreenMapLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Location')),
      body: Column(
        children: [
          GoogleMapWidget(),
          ConfirmLocationButton(
            onConfirmLocationPressed: () {
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
import '../widgets_map_location/google_map.dart';
import '../widgets_map_location/confirm_location.dart';
import '../../customer_acc_pwd/screens_acc_pwd/screen_acc_pwd.dart';

class ScreenMapLocation extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String addressNo;
  final String street;
  final String city;
  final String district;

  ScreenMapLocation({
    required this.name,
    required this.phone,
    required this.email,
    required this.addressNo,
    required this.street,
    required this.city,
    required this.district,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Location')),
      body: Column(
        children: [
          GoogleMapWidget(),
          ConfirmLocationButton(
            onConfirmLocationPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenAccPwd(
                    name: name,
                    phone: phone,
                    email: email,
                    addressNo: addressNo,
                    street: street,
                    city: city,
                    district: district,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
