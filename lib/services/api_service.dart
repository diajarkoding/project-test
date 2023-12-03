import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/',
      connectTimeout: const Duration(milliseconds: 100000),
      // receiveTimeout: 100000,
      validateStatus: (status) {
        return status != null && status > 0;
      },
    ),
  );

  Future<void> register(
      {required String email, required String password}) async {
    try {
      const String url = "api/register";

      final Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print("Response: ${response.data}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
