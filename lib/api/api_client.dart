import 'dart:convert';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> login(String endpoint, Map<String, dynamic> body) async {
    String token=SharedprefrencesService().getToken().toString();
    return await http.post(Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json',"Authorization": "Bearer $token",}, body: jsonEncode(body));
  }

  Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {

    String? token = await SharedprefrencesService().getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Token missing. Please login again.");
    }

    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    return await http.get(Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? {});
  }
  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    final token = await SharedprefrencesService().getToken();

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response;
  }
}
