import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_test/model/user_profile_model.dart';
import 'package:project_test/utils/data_box.dart';

class ProfileController extends GetxController {
  final _hive = HiveDataStore();

  UserProfileModel? _userModel;
  UserProfileModel? get userModel => _userModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getUserDataFromFirestore() async {
    _isLoading = true;

    final userId = _hive.getUserId();

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      _userModel = UserProfileModel.fromJSON(snapshot.data()!);

      _isLoading = false;
      update();
    } else {
      _isLoading = false;
      update();

      throw Exception('User data not found!');
    }
  }
}
