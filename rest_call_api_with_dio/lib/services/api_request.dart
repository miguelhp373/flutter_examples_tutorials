// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiRequest {
  final _basePathURL = 'https://reqres.in/api';

  Future<Response<dynamic>> fetchData(String pathName) async {
    try {
      final dio = Dio();
      return await dio.get(_basePathURL + pathName);
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<Response<dynamic>> putData(
    String pathName,
    int userId,
    dynamic data,
  ) async {
    try {
      final dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      return await dio.put(_basePathURL + pathName, data: data);
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<Response<dynamic>> deleteData(String pathName) {
    try {
      final dio = Dio();
      return dio.delete(_basePathURL + pathName);
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }
}
