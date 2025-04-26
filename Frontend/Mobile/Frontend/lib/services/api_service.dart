import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class ApiService {
  // Get the appropriate base URL depending on platform
  static String get baseUrl {
    if (kIsWeb) {
      // For web platform
      return 'http://localhost:4000/api/users';
    } else if (Platform.isAndroid) {
      // For Android emulator
      return 'http://10.0.2.2:4000/api/users';
    } else {
      // For iOS simulator or physical devices
      return 'http://localhost:4000/api/users';
    }
  }

  // Check if a phone number is already registered
  static Future<bool> isPhoneNumberRegistered(String phone) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customers/check-phone/$phone'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['isRegistered'] ?? false;
      } else if (response.statusCode == 404) {
        return false; // Phone number not found
      } else {
        throw Exception('Failed to check phone number');
      }
    } catch (e) {
      throw Exception('Error checking phone number: $e');
    }
  }

  static Future<Map<String, dynamic>> registerCustomer(
      Customer customer) async {
    try {
      // Create a copy of the customer data
      final Map<String, dynamic> requestBody = customer.toJson();

      // Remove any existing location field to avoid conflicts
      requestBody.remove('location');

      // Add properly formatted location field
      requestBody['location'] = {
        'type': 'Point',
        'coordinates': [0.0, 0.0]
      };

      // Ensure wasteTypes is an empty array for customers
      requestBody['wasteTypes'] = [];

      // Add role field for customer
      requestBody['role'] = 'customer';

      print('Attempting to register customer');
      print('Request URL: $baseUrl/register');
      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http
          .post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out. Please try again.');
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Registration successful',
          'data': responseData['user'] ?? responseData,
        };
      } else {
        print('Server returned error status: ${response.statusCode}');
        print('Error response body: ${response.body}');

        String message;
        try {
          final responseData = jsonDecode(response.body);
          message = responseData['message'] ??
              responseData['error'] ??
              'Server error occurred';
        } catch (e) {
          message = 'Server error occurred';
        }

        return {
          'success': false,
          'message': message,
        };
      }
    } catch (e) {
      print('Detailed error during registration: $e');
      String errorMessage;

      if (e is TimeoutException) {
        errorMessage = 'Connection timed out. Please try again.';
      } else if (e.toString().contains('XMLHttpRequest error')) {
        errorMessage =
            'CORS error: Please ensure the backend server has CORS enabled';
      } else if (e.toString().contains('Connection refused')) {
        errorMessage =
            'Could not connect to the server. Please ensure the backend is running on port 4000';
      } else {
        errorMessage = 'Network error: ${e.toString()}';
      }

      print('Error message: $errorMessage');
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password, String role) async {
    try {
      final response = await http
          .post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'role': role,
        }),
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out. Please try again.');
        },
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
          'token': responseData['token'],
          'user': responseData['user'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      print('Error during login: $e');
      String errorMessage;

      if (e is TimeoutException) {
        errorMessage = 'Connection timed out. Please try again.';
      } else if (e.toString().contains('XMLHttpRequest error')) {
        errorMessage =
            'CORS error: Please ensure the backend server has CORS enabled';
      } else if (e.toString().contains('Connection refused')) {
        errorMessage =
            'Could not connect to the server. Please ensure the backend is running on port 4000';
      } else {
        errorMessage = 'Network error: Failed to connect to server';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  // Deprecated: Use login() instead
  static Future<Map<String, dynamic>> loginCustomer(
      String email, String password) async {
    return login(email, password, 'customer');
  }

  // Helper method for collector login
  static Future<Map<String, dynamic>> loginCollector(
      String email, String password) async {
    return login(email, password, 'collector');
  }
}
