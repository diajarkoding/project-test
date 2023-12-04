import 'package:get/get.dart';
import 'package:project_test/presentation/bindings/auth_binding.dart';
import 'package:project_test/presentation/bindings/dahsboard_binding.dart';
import 'package:project_test/presentation/controllers/dashboard_controller.dart';
import 'package:project_test/presentation/pages/dashboard/dashboard_page.dart';
import 'package:project_test/presentation/pages/login_page.dart';
import 'package:project_test/presentation/pages/register_page.dart';
import 'package:project_test/presentation/pages/splash_page.dart';
import 'package:project_test/routes/route_name.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splashPage,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.loginPage,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.registerPage,
      page: () => const RegisterPage(),
      transition: Transition.fadeIn,
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.dashboardPage,
      page: () => const DashboardPage(),
      transition: Transition.fadeIn,
      binding: DashboardBinding(),
    ),
  ];
}
