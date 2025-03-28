import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://api.fluttercrypto.agpro.co.in";

  /// **Login User**
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      log("Login Response: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseBody["data"] ?? {};
      } else {
        return {"error": responseBody["message"] ?? "Login failed"};
      }
    } catch (e) {
      print("Login Error: $e");
      return {"error": "An unexpected error occurred. Please try again."};
    }
  }

  /// **Sign Up User**
  Future<Map<String, dynamic>> signupUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "role": "bf6c3d87-3564-43ac-a172-5614bbc40811",
          "first_name": name,
        }),
      );

      log("Signup Response: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 204) {
        return {"success": true};
      } else {
        return {"error": responseBody["message"] ?? "Signup failed"};
      }
    } catch (e) {
      print("Signup Error: $e");
      return {"error": "An unexpected error occurred. Please try again."};
    }
  }

  /// **Logout User**
  Future<bool> logoutUser(String token) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/logout"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      log("Logout Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Logout Error: $e");
      return false;
    }
  }
}
