import 'package:flutter/material.dart';
import 'package:eco_lift/services/api_service.dart';
import 'package:eco_lift/models/customer.dart';
import 'package:eco_lift/screens/map_location.dart';
import 'package:eco_lift/screens/customer_registration_complete.dart';

class CustomerAddress extends StatefulWidget {
  final Customer customer;

  const CustomerAddress({Key? key, required this.customer}) : super(key: key);

  @override
  _CustomerAddressState createState() => _CustomerAddressState();
}

class _CustomerAddressState extends State<CustomerAddress> {
  final _formKey = GlobalKey<FormState>();
  final _addressNoController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  String? _selectedDistrict;
  bool _isLoading = false;
  String? _errorMessage;

  // List of Sri Lankan districts
  final List<String> _districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya'
  ];

  @override
  void dispose() {
    _addressNoController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _selectLocationOnMap() async {
    final selectedLocation = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocation(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _addressNoController.text = selectedLocation['addressNo'] ?? '';
        _streetController.text = selectedLocation['street'] ?? '';
        _cityController.text = selectedLocation['city'] ?? '';
        _selectedDistrict = selectedLocation['district'] ?? '';
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Additional validation for district
      if (_selectedDistrict == null || _selectedDistrict!.isEmpty) {
        setState(() {
          _errorMessage = 'Please select your district';
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Validate all address fields are filled
        if (_addressNoController.text.isEmpty ||
            _streetController.text.isEmpty ||
            _cityController.text.isEmpty ||
            _selectedDistrict == null) {
          setState(() {
            _errorMessage = 'All address fields are required';
          });
          return;
        }

        // Pass address components separately
        Navigator.pushNamed(
          context,
          '/customer_password',
          arguments: {
            'name': widget.customer.name,
            'email': widget.customer.email,
            'phone': widget.customer.phone,
            'addressNo': _addressNoController.text.trim(),
            'street': _streetController.text.trim(),
            'city': _cityController.text.trim(),
            'district': _selectedDistrict,
          },
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter your address details or select your location on the map',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              TextFormField(
                controller: _addressNoController,
                decoration: const InputDecoration(
                  labelText: 'Address Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: const InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
                items: _districts.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your district';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _selectLocationOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select Location on Map'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Continue'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
