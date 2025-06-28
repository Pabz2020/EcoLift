import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CollectorDashboard extends StatefulWidget {
  const CollectorDashboard({super.key});

  @override
  State<CollectorDashboard> createState() => _CollectorDashboardState();
}

class _CollectorDashboardState extends State<CollectorDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    _CollectorMapView(),
    Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
    Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
    Center(child: Text('Wallet', style: TextStyle(fontSize: 24))),
    Center(child: Text('Scheduled Pickups', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Scheduled',
          ),
        ],
      ),
    );
  }
}

class _CollectorMapView extends StatelessWidget {
  const _CollectorMapView();

  @override
  Widget build(BuildContext context) {
    // Default location (Colombo, Sri Lanka)
    final LatLng defaultLocation = LatLng(6.9271, 79.8612);
    return FlutterMap(
      options: MapOptions(
        initialCenter: defaultLocation,
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }
}
