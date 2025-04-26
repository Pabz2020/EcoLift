import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/pickup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupConfirmation extends StatefulWidget {
  final List<String> selectedWasteTypes;
  final LatLng location;
  final String address;
  final DateTime? scheduledDateTime;

  const PickupConfirmation({
    super.key,
    required this.selectedWasteTypes,
    required this.location,
    required this.address,
    this.scheduledDateTime,
  });

  @override
  State<PickupConfirmation> createState() => _PickupConfirmationState();
}

class _PickupConfirmationState extends State<PickupConfirmation> {
  final PickupService _pickupService = PickupService();
  bool _isLoading = false;

  Future<void> _submitPickupRequest() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the user ID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) {
        throw Exception('User not logged in');
      }

      final result = await _pickupService.createPickupRequest(
        userId: userId,
        coordinates: [widget.location.longitude, widget.location.latitude],
        wasteTypes: widget.selectedWasteTypes,
        isInstant: widget.scheduledDateTime == null,
        scheduledTime: widget.scheduledDateTime,
      );

      if (mounted) {
        if (result['success']) {
          // Show success message and navigate back to dashboard
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pickup request submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (route) => false,
          );
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result['error'] ?? 'Failed to submit pickup request'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Pickup'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pickup Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Location',
                      widget.address.isEmpty
                          ? 'Selected location on map'
                          : widget.address,
                      Icons.location_on,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Waste Types',
                      widget.selectedWasteTypes.join(', '),
                      Icons.delete_outline,
                    ),
                    if (widget.scheduledDateTime != null) ...[
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        'Scheduled Time',
                        '${widget.scheduledDateTime!.day}/${widget.scheduledDateTime!.month}/${widget.scheduledDateTime!.year} at ${widget.scheduledDateTime!.hour}:${widget.scheduledDateTime!.minute.toString().padLeft(2, '0')}',
                        Icons.schedule,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitPickupRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Confirm Pickup Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
