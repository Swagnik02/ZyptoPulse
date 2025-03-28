import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class FavoriteService {
  static const String baseUrl = "https://api.fluttercrypto.agpro.co.in";

  /// Save Favorite Crypto
  Future<bool> saveFavorite(
    String token,
    Map<String, dynamic> cryptoData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/items/crypto_favorites"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(cryptoData),
      );

      log("Save Favorite Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        log("Save Favorite Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Save Favorite Error: $e");
      return false;
    }
  }

  /// Get User Favorites
  Future<List<dynamic>> getFavorites(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/items/crypto_favorites"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      log("Get Favorites Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return decoded.containsKey("data") ? decoded["data"] : [];
      } else {
        log("Get Favorites Failed: ${response.body}");
        return [];
      }
    } catch (e) {
      log("Get Favorites Error: $e");
      return [];
    }
  }

  /// Delete Favorite
  Future<bool> deleteFavorite(String token, String itemId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/items/crypto_favorites/$itemId"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      log(
        "Delete Favorite Response (${response.statusCode}): ${response.body}",
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        log("Delete Favorite Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Delete Favorite Error: $e");
      return false;
    }
  }
}
