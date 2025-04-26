import 'package:flutter/material.dart';

class WasteType {
  final String name;
  final IconData icon;
  final String description;

  const WasteType({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class ScheduledWasteTypeSelection extends StatefulWidget {
  const ScheduledWasteTypeSelection({super.key});

  @override
  State<ScheduledWasteTypeSelection> createState() =>
      _ScheduledWasteTypeSelectionState();
}

class _ScheduledWasteTypeSelectionState
    extends State<ScheduledWasteTypeSelection> {
  final List<WasteType> wasteTypes = const [
    WasteType(
      name: 'Plastic',
      icon: Icons.local_drink,
      description: 'Bottles, containers, packaging',
    ),
    WasteType(
      name: 'Paper',
      icon: Icons.description,
      description: 'Newspapers, cardboard, magazines',
    ),
    WasteType(
      name: 'Glass',
      icon: Icons.wine_bar,
      description: 'Bottles, jars, broken glass',
    ),
    WasteType(
      name: 'Metal',
      icon: Icons.hardware,
      description: 'Cans, aluminum, scrap metal',
    ),
    WasteType(
      name: 'E-waste',
      icon: Icons.devices,
      description: 'Electronics, batteries, appliances',
    ),
    WasteType(
      name: 'Organic',
      icon: Icons.eco,
      description: 'Food waste, garden waste',
    ),
  ];

  final Set<String> _selectedTypes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Waste Types'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Select all types of waste you want to dispose of',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: wasteTypes.length,
              itemBuilder: (context, index) {
                final waste = wasteTypes[index];
                final isSelected = _selectedTypes.contains(waste.name);

                return Material(
                  color: isSelected ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTypes.remove(waste.name);
                        } else {
                          _selectedTypes.add(waste.name);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected ? Colors.green : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            waste.icon,
                            size: 32,
                            color: isSelected ? Colors.green : Colors.grey[600],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            waste.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.green : Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            waste.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _selectedTypes.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(
                        context,
                        '/scheduled_pickup_datetime',
                        arguments: {
                          'selectedWasteTypes': _selectedTypes.toList(),
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _selectedTypes.isEmpty
                    ? 'Select Waste Types'
                    : 'Continue to Schedule',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
