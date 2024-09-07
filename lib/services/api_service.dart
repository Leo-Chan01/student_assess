import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:student_assess/view_model/utils/resources/string_resources.dart';

class ApiService {
  final String baseUrl = AppStrings.apiBaseUrl;

  Dio dio = Dio();

  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await dio.get('$baseUrl/$endpoint');

    if (response.statusCode == 200) {
      return json.decode(response.data);
    } else if (response.statusCode == 502) {
      throw Exception('Failed to load data because of bad gateway');
    } else {
      throw Exception('Unexpected error');
    }
  }

  Future<Map<String, dynamic>?> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await dio.post(
      '$baseUrl/$endpoint',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: json.encode(data),
    );

    if (response.statusCode != 200) {
      log("Failed to send comparison");
      return null;
    } else {
      log("Comparison successful");
      return response.data as Map<String, dynamic>;
    }
  }
}
