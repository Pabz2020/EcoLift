import 'dart:convert';
import 'package:http/http.dart' as http;

class PickupService {
  static const String baseUrl =
      'http://your-backend-url/api'; // Replace with your actual backend URL

  static Future<void> createInstantPickup({
    required List<String> wasteTypes,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pickups/instant'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'wasteTypes': wasteTypes,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create instant pickup: ${response.body}');
    }
  }

  static Future<void> createScheduledPickup({
    required List<String> wasteTypes,
    required double latitude,
    required double longitude,
    required String address,
    required DateTime scheduledDateTime,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pickups/scheduled'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'wasteTypes': wasteTypes,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'scheduledDateTime': scheduledDateTime.toIso8601String(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create scheduled pickup: ${response.body}');
    }
  }
}
