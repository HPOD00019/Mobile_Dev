import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final response = await _client.post(
      uri,
      headers: _defaultHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception(
        'Request failed: ${response.statusCode} ${response.body}',
      );
    }
  }
  
  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final response = await _client.get(uri, headers: _defaultHeaders);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception(
        'Request failed: ${response.statusCode} ${response.body}',
      );
    }
  }

  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  void dispose() {
    _client.close();
  }
}