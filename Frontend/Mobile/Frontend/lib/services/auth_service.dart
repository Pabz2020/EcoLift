import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      'http://10.0.2.2:4000/api/users'; // Using 10.0.2.2 for Android emulator

  Future<Map<String, dynamic>> registerCollector({
    required String name,
    required String phone,
    required String email,
    required String password,
    required List<double> coordinates,
    required String vehicleType,
    required List<String> wasteTypes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'role': 'collector',
          'location': {
            'type': 'Point',
            'coordinates': coordinates,
          },
          'vehicleType': vehicleType,
          'wasteTypes': wasteTypes,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'error': data['message'] ?? 'Registration failed',
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
