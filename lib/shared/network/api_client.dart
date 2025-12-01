// lib/shared/network/api_client.dart

import 'package:http/http.dart' as http;
import 'api_config.dart';

/// Cliente HTTP simple que usaremos en todos los bounded context.
/// Es el equivalente a tu RetrofitInstance.
class ApiClient {
  ApiClient._(); // constructor privado, solo métodos estáticos

  static final http.Client _client = http.Client();

  /// Construye la URI a partir del path y opcionalmente query parameters.
  /// Ejemplo: buildUri('/users', {'role': 'company'})
  static Uri buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    final uri = Uri.parse('$baseUrl$path');
    return uri.replace(queryParameters: queryParameters);
  }

  static Future<http.Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) {
    return _client.get(buildUri(path, queryParameters));
  }

  static Future<http.Response> post(
      String path, {
        Map<String, dynamic>? queryParameters,
        Object? body,
        Map<String, String>? headers,
      }) {
    return _client.post(
      buildUri(path, queryParameters),
      body: body,
      headers: headers,
    );
  }

  static Future<http.Response> put(
      String path, {
        Map<String, dynamic>? queryParameters,
        Object? body,
        Map<String, String>? headers,
      }) {
    return _client.put(
      buildUri(path, queryParameters),
      body: body,
      headers: headers,
    );
  }

  static Future<http.Response> delete(
      String path, {
        Map<String, dynamic>? queryParameters,
        Object? body,
        Map<String, String>? headers,
      }) {
    return _client.delete(
      buildUri(path, queryParameters),
      body: body,
      headers: headers,
    );
  }
}
