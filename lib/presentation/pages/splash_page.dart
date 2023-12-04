import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/routes/route_name.dart';
import 'package:project_test/utils/data_box.dart';
import 'package:project_test/utils/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    final hive = HiveDataStore();

    await hive.initSecureBox();

    final isLogin = hive.getLogin();

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      if (isLogin == true) {
        Get.offNamed(Routes.dashboardPage);
      } else {
        Get.offNamed(Routes.loginPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor1,
      body: Center(
        child: Text(
          'Loading ...',
          style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
      ),
    );
  }
}
