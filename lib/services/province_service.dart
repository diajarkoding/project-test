import 'dart:convert';
import 'package:dio/dio.dart';

class ProvinceService {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 100000),
      // receiveTimeout: 100000,
      validateStatus: (status) {
        return status != null && status > 0;
      },
    ),
  );

  String baseUrl =
      'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json';

  Future<List<String>> fetchProvinces() async {
    final response = await dio.get(baseUrl);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.data);
      final List<String> provinces = [];

      for (var province in jsonData) {
        provinces.add(province['name']);
      }

      return provinces;
    } else {
      throw Exception('Failed to fetch provinces');
    }
  }
}
