import 'package:get/get.dart';
import 'package:project_test/model/users_model.dart';
import 'package:project_test/services/api_service.dart';

class UsersController extends GetxController {
  final _api = ApiService();

  List<UsersModel>? _usersModel;
  List<UsersModel>? get usersModel => _usersModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getUserDataFromFirestore() async {
    _isLoading = true;

    List<UsersModel> listUser = await _api.getUsers(1);

    if (listUser.isNotEmpty) {
      _usersModel = listUser;

      _isLoading = false;
      update();
    } else {
      _isLoading = false;
      update();

      throw Exception('Users data not found!');
    }
  }
}
