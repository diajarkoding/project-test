import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/dashboard_controller.dart';
import 'package:project_test/presentation/controllers/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
