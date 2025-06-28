import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PickupService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:5000'; // For iOS simulator
  // static const String baseUrl = 'http://your-actual-ip:5000'; // For physical device

  static Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> createInstantPickup({
    required List<String> wasteTypes,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final authToken = await _getAuthToken();
    if (authToken == null) {
      throw Exception('Authentication token not found. Please login again.');
    }

    // Convert waste types to items format expected by backend
    final items = wasteTypes
        .map((type) => {
              'type': type,
              'quantity': 1, // Default quantity of 1 for each waste type
              'description': 'Instant pickup request for $type waste'
            })
        .toList();

    final response = await http.post(
      Uri.parse('$baseUrl/api/pickups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'location': {
          'type': 'Point',
          'coordinates': [longitude, latitude],
        },
        'items': items,
        // No scheduledTime for instant pickup
      }),
    );

    if (response.statusCode != 201) {
      final errorBody = jsonDecode(response.body);
      throw Exception(
          'Failed to create instant pickup: ${errorBody['message'] ?? response.body}');
    }
  }

  static Future<void> createScheduledPickup({
    required List<String> wasteTypes,
    required double latitude,
    required double longitude,
    required String address,
    required DateTime scheduledDateTime,
  }) async {
    final authToken = await _getAuthToken();
    if (authToken == null) {
      throw Exception('Authentication token not found. Please login again.');
    }

    // Convert waste types to items format expected by backend
    final items = wasteTypes
        .map((type) => {
              'type': type,
              'quantity': 1, // Default quantity of 1 for each waste type
              'description': 'Scheduled pickup request for $type waste'
            })
        .toList();

    final response = await http.post(
      Uri.parse('$baseUrl/api/pickups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'location': {
          'type': 'Point',
          'coordinates': [longitude, latitude],
        },
        'items': items,
        'scheduledTime': scheduledDateTime.toIso8601String(),
      }),
    );

    if (response.statusCode != 201) {
      final errorBody = jsonDecode(response.body);
      throw Exception(
          'Failed to create scheduled pickup: ${errorBody['message'] ?? response.body}');
    }
  }
}
