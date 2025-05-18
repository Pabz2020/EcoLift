import 'package:flutter/material.dart';

class CollectorWasteTypes extends StatefulWidget {
  final Map<String, dynamic> collectorInfo;

  const CollectorWasteTypes({super.key, required this.collectorInfo});

  @override
  _CollectorWasteTypesState createState() => _CollectorWasteTypesState();
}

class _CollectorWasteTypesState extends State<CollectorWasteTypes> {
  final List<String> _selectedWasteTypes = [];
  final List<String> _wasteTypes = [
    'Plastic',
    'Paper',
    'Glass',
    'Metal',
    'Organic',
    'Electronic',
    'Hazardous',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Types'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Step 3 of 4',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select the types of waste you can collect',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: _wasteTypes
                    .map((type) => CheckboxListTile(
                          title: Text(type),
                          value: _selectedWasteTypes.contains(type),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedWasteTypes.add(type);
                              } else {
                                _selectedWasteTypes.remove(type);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
            if (_selectedWasteTypes.isEmpty)
              const Text(
                'Please select at least one waste type',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedWasteTypes.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        '/collector_password',
                        arguments: {
                          ...widget.collectorInfo,
                          'wasteTypes': _selectedWasteTypes,
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
