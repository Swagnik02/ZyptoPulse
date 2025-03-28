import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoApiService {
  static const String _baseUrl =
      "https://api.coingecko.com/api/v3/coins/markets";

  Future<List<dynamic>> fetchMarketData({
    String vsCurrency = "usd",
    String order = "market_cap_desc",
    int perPage = 20,
    int pageNum = 1,
    bool sparkline = false,
  }) async {
    try {
      final url = Uri.parse(
        "$_baseUrl?"
        "vs_currency=$vsCurrency&"
        "order=$order&"
        "per_page=$perPage&"
        "page=$pageNum&"
        "sparkline=$sparkline",
      );

      final headers = {
        "Accept": "application/json",
        "User-Agent": "CryptoApp/1.0",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Error ${response.statusCode}: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
