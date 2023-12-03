import 'package:get/get.dart';
import 'package:project_test/services/api_service.dart';

class AuthController extends GetxController {
  final apiService = ApiService();

  Future<void> register(
      {required String email, required String password}) async {
    var response = await apiService.register(email: email, password: password);
  }
}
