import 'package:flutter/material.dart';

class DateTimeSelection extends StatefulWidget {
  final List<String> selectedWasteTypes;

  const DateTimeSelection({
    super.key,
    required this.selectedWasteTypes,
  });

  @override
  State<DateTimeSelection> createState() => _DateTimeSelectionState();
}

class _DateTimeSelectionState extends State<DateTimeSelection> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Pickup'),
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
                    'Select your preferred date and time for waste collection',
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Waste Types:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.selectedWasteTypes.map((type) {
                      return Chip(
                        label: Text(type),
                        backgroundColor: Colors.green.shade100,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    leading:
                        const Icon(Icons.calendar_today, color: Colors.green),
                    title: const Text('Select Date'),
                    subtitle: _selectedDate != null
                        ? Text(
                            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
                        : const Text('No date selected'),
                    onTap: () => _selectDate(context),
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.green),
                    title: const Text('Select Time'),
                    subtitle: _selectedTime != null
                        ? Text(_selectedTime!.format(context))
                        : const Text('No time selected'),
                    onTap: () => _selectTime(context),
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: (_selectedDate != null && _selectedTime != null)
                  ? () {
                      final scheduledDateTime = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        _selectedTime!.hour,
                        _selectedTime!.minute,
                      );

                      Navigator.pushNamed(
                        context,
                        '/scheduled_pickup_location',
                        arguments: {
                          'selectedWasteTypes': widget.selectedWasteTypes,
                          'scheduledDateTime': scheduledDateTime,
                        },
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue to Location',
                style: TextStyle(
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
