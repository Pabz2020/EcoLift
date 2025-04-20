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

  static Future<Map<String, dynamic>> registerCustomer(
      Customer customer) async {
    try {
      // Use the customer's toJson method to create the request body
      final requestBody = customer.toJson();

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

  static Future<Map<String, dynamic>> loginCustomer(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

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
      return {
        'success': false,
        'message': 'Network error: Failed to connect to server',
      };
    }
  }
}
