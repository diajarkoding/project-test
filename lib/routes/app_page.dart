import 'package:get/get.dart';
import 'package:project_test/presentation/bindings/auth_binding.dart';
import 'package:project_test/presentation/pages/home_page.dart';
import 'package:project_test/presentation/pages/login_page.dart';
import 'package:project_test/presentation/pages/register_page.dart';
import 'package:project_test/routes/route_name.dart';

class AppPages {
  static final routes = [
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
      name: Routes.homePage,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      binding: AuthBinding(),
    ),
  ];
}
