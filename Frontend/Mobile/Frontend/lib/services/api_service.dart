import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiService {
  static const String userServiceUrl = 'http://10.0.2.2:4000/api';
  static const String pickupServiceUrl = 'http://10.0.2.2:5000/api';
  static String? _authToken;
  static WebSocketChannel? _wsChannel;

  // Set auth token
  static void setAuthToken(String token) {
    _authToken = token;
  }

  // Get headers with auth token
  static Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      if (_authToken != null) 'Authorization': 'Bearer $_authToken',
    };
  }

  // Test connection
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$userServiceUrl/users/test'),
        headers: _headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test error: $e');
      return false;
    }
  }

  // User registration
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String phone,
    required String email,
    required String addressNo,
    required String street,
    required String city,
    required String district,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$userServiceUrl/users/register'),
        headers: _headers,
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'email': email,
          'role': role,
          'address': {
            'addressNo': addressNo,
            'street': street,
            'city': city,
            'district': district,
          },
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          setAuthToken(data['token']);
        }
        return data;
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  // User login
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$userServiceUrl/users/login'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          setAuthToken(data['token']);
        }
        return data;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  // Get user profile
  static Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$userServiceUrl/users/profile'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting profile: $e');
    }
  }

  // Update collector location
  static Future<void> updateCollectorLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$userServiceUrl/users/collectors/location'),
        headers: _headers,
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update location: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating location: $e');
    }
  }

  // Get nearby collectors
  static Future<List<dynamic>> getNearbyCollectors({
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$userServiceUrl/users/collectors/nearby?lat=$latitude&lng=$longitude&radius=$radius'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['collectors'] ?? [];
      } else {
        throw Exception('Failed to get nearby collectors: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting nearby collectors: $e');
    }
  }

  // Create pickup request
  static Future<Map<String, dynamic>> createPickupRequest({
    required String wasteType,
    required String description,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$pickupServiceUrl/pickups'),
        headers: _headers,
        body: jsonEncode({
          'wasteType': wasteType,
          'description': description,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create pickup request: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating pickup request: $e');
    }
  }

  // Get pending pickup requests
  static Future<List<dynamic>> getPendingRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$pickupServiceUrl/pickups/pending'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['requests'] ?? [];
      } else {
        throw Exception('Failed to get pending requests: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting pending requests: $e');
    }
  }

  // Accept pickup request
  static Future<Map<String, dynamic>> acceptPickupRequest(
      String requestId) async {
    try {
      final response = await http.post(
        Uri.parse('$pickupServiceUrl/pickups/accept'),
        headers: _headers,
        body: jsonEncode({
          'requestId': requestId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to accept pickup request: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error accepting pickup request: $e');
    }
  }

  // Connect to WebSocket
  static void connectWebSocket() {
    if (_wsChannel != null) {
      _wsChannel!.sink.close();
    }

    _wsChannel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:5000'),
    );
  }

  // Listen to WebSocket messages
  static Stream<dynamic> get wsStream => _wsChannel!.stream;

  // Send WebSocket message
  static void sendWsMessage(Map<String, dynamic> message) {
    if (_wsChannel != null) {
      _wsChannel!.sink.add(jsonEncode(message));
    }
  }

  // Close WebSocket connection
  static void closeWebSocket() {
    if (_wsChannel != null) {
      _wsChannel!.sink.close();
      _wsChannel = null;
    }
  }
}
