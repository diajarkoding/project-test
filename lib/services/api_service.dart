import 'package:dio/dio.dart';
import 'package:project_test/model/users_model.dart';

class ApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/',
      connectTimeout: const Duration(milliseconds: 100000),
      validateStatus: (status) {
        return status != null && status > 0;
      },
    ),
  );

  Future<List<UsersModel>> getUsers(int page) async {
    final response = await dio.get('/api/users?page=$page');

    if (response.statusCode == 200) {
      final jsonData = response.data;

      final List<dynamic> dataList = jsonData['data'] as List<dynamic>;

      final userList =
          dataList.map((item) => UsersModel.fromJSON(item)).toList();

      return userList;
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
