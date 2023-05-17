// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiRequest {
  Future<Response<dynamic>> fetchData(String pathName) async {
    try {
      final dio = Dio();
      return await dio.get('https://reqres.in/api$pathName');
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }
}
