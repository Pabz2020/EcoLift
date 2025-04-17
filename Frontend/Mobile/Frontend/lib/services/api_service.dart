import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class ApiService {
  // Use your computer's IP address instead of localhost
  static const String baseUrl =
      'http://192.168.1.100:4000/api/users'; // User Service runs on port 4000

  static Future<Map<String, dynamic>> registerCustomer(
      Customer customer) async {
    try {
      print('Sending request to: $baseUrl/register'); // Debug print
      print('Request body: ${jsonEncode({
            'name': customer.name,
            'email': customer.email,
            'phone': customer.phone,
            'addressNo': customer.address?.split(',')[0].trim(),
            'street': customer.address?.split(',')[1].trim(),
            'city': customer.city,
            'district': customer.district,
            'role': 'customer'
          })}'); // Debug print

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': customer.name,
          'email': customer.email,
          'phone': customer.phone,
          'addressNo': customer.address?.split(',')[0].trim(),
          'street': customer.address?.split(',')[1].trim(),
          'city': customer.city,
          'district': customer.district,
          'role': 'customer'
        }),
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Backend returns 200 for successful registration
        return {
          'success': true,
          'message': responseData['message'] ?? 'Registration successful',
          'data':
              responseData['user'], // Backend returns user data in 'user' field
        };
      } else if (response.statusCode == 400) {
        return {
          'success': false,
          'message': responseData['error'] ??
              'Invalid input data', // Backend returns errors in 'error' field
        };
      } else if (response.statusCode == 409) {
        return {
          'success': false,
          'message': responseData['error'] ?? 'Email or phone already exists',
        };
      } else {
        return {
          'success': false,
          'message': responseData['error'] ?? 'Registration failed',
        };
      }
    } on http.ClientException catch (e) {
      print('Network error: $e'); // Debug print
      return {
        'success': false,
        'message':
            'Network error: ${e.message}. Please check your connection and try again.',
      };
    } catch (e) {
      print('Unexpected error: $e'); // Debug print
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Add other customer-related API methods here
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
          'message': responseData['message'] ?? 'Login successful',
          'token': responseData['token'],
          'user': responseData['user'],
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'message': responseData['error'] ?? 'Invalid credentials',
        };
      } else {
        return {
          'success': false,
          'message': responseData['error'] ?? 'Login failed',
        };
      }
    } on http.ClientException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }
}
