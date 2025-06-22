// lib/main.dart
//import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:geolocator/geolocator.dart';
import 'screens/welcome_page.dart';
import 'screens/about_app.dart';
import 'screens/role_selection.dart';
import 'screens/customer_personal_info.dart';
import 'screens/customer_address.dart';
import 'screens/customer_password.dart';
import 'screens/map_location.dart';
import 'screens/collector_personal_info.dart';
import 'screens/collector_vehicle.dart';
import 'screens/collector_waste_types.dart';
import 'screens/collector_password.dart';
import 'screens/collector_registration_success.dart';
import 'screens/customer_welcome.dart';
import 'screens/customer_registration_complete.dart';
import 'screens/collector_welcome.dart';
import 'screens/login_role_selection.dart';
import 'screens/login_screen.dart';
import 'screens/customer_dashboard.dart';
import 'screens/customer_profile.dart';
import 'screens/instant_pickup/waste_type_selection.dart';
import 'screens/instant_pickup/location_selection.dart' as instant_location;
import 'screens/instant_pickup/confirmation.dart' as instant_confirmation;
import 'screens/scheduled_pickup/waste_type_selection.dart';
import 'screens/scheduled_pickup/datetime_selection.dart';
import 'screens/scheduled_pickup/location_selection.dart' as scheduled_location;
import 'screens/scheduled_pickup/confirmation.dart' as scheduled_confirmation;
import 'models/customer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request location permissions
  await _requestLocationPermission();

  runApp(const EcoLiftApp());
}

Future<void> _requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return;
  }
}

class EcoLiftApp extends StatelessWidget {
  const EcoLiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoLift',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/about_app': (context) => const AboutApp(),
        '/role_selection': (context) => const RoleSelection(),
        '/login_role_selection': (context) => const LoginRoleSelection(),
        '/login': (context) => const LoginScreen(),
        '/customer_dashboard': (context) {
          final userData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return CustomerDashboard(userData: userData);
        },
        '/customer_welcome': (context) => const CustomerWelcome(),
        '/customer_personal_info': (context) => const CustomerPersonalInfo(),
        '/instant_pickup': (context) => const WasteTypeSelection(),
        '/instant_pickup_location': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return instant_location.LocationSelection(
            selectedWasteTypes:
                args?['selectedWasteTypes'] as List<String>? ?? [],
          );
        },
        '/scheduled_pickup': (context) => const ScheduledWasteTypeSelection(),
        '/scheduled_pickup_datetime': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return DateTimeSelection(
            selectedWasteTypes:
                args?['selectedWasteTypes'] as List<String>? ?? [],
          );
        },
        '/scheduled_pickup_location': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return scheduled_location.LocationSelection(
            selectedWasteTypes:
                args?['selectedWasteTypes'] as List<String>? ?? [],
            scheduledDateTime: args?['scheduledDateTime'] as DateTime?,
          );
        },
        '/instant_pickup_confirmation': (context) =>
            const instant_confirmation.PickupConfirmation(),
        '/scheduled_pickup_confirmation': (context) =>
            const scheduled_confirmation.PickupConfirmation(),
        '/customer_address': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return CustomerAddress(
            customer: Customer(
              name: args?['name'] ?? '',
              email: args?['email'] ?? '',
              phone: args?['phone'] ?? '',
            ),
          );
        },
        '/customer_password': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return CustomerPassword(customerInfo: args ?? {});
        },
        '/customer_registration_complete': (context) {
          final customer =
              ModalRoute.of(context)?.settings.arguments as Customer;
          return CustomerRegistrationComplete(customer: customer);
        },
        '/map_location': (context) => const MapLocation(),
        '/collector_welcome': (context) => const CollectorWelcome(),
        '/collector_personal_info': (context) => const CollectorPersonalInfo(),
        '/collector_vehicle': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return CollectorVehicle(personalInfo: args ?? {});
        },
        '/collector_waste_types': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return CollectorWasteTypes(collectorInfo: args ?? {});
        },
        '/collector_password': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return CollectorPassword(collectorInfo: args ?? {});
        },
        '/collector_registration_success': (context) =>
            const CollectorRegistrationSuccess(),
        '/customer_profile': (context) {
          final userData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return CustomerProfile(userData: userData);
        },
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ecolift_logo.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(
                'EcoLift',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Making Sri Lanka Cleaner and Greener',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
