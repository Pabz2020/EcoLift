import 'dart:convert';
import 'package:http/http.dart' as http;

class PickupService {
  static const String baseUrl =
      'http://10.0.2.2:5000/api/pickups'; // Using 10.0.2.2 for Android emulator

  Future<Map<String, dynamic>> createPickupRequest({
    required String userId,
    required List<double> coordinates,
    required List<String> wasteTypes,
    required bool isInstant,
    DateTime? scheduledTime,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'location': {
            'type': 'Point',
            'coordinates': coordinates,
          },
          'wasteTypes': wasteTypes,
          'isInstant': isInstant,
          if (scheduledTime != null)
            'scheduledTime': scheduledTime.toIso8601String(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'error': data['message'] ?? 'Failed to create pickup request',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getPickupRequests(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'error': data['message'] ?? 'Failed to fetch pickup requests',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }
}
