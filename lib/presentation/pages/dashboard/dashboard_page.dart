import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/dashboard_controller.dart';
import 'package:project_test/presentation/controllers/profile_controller.dart';
import 'package:project_test/presentation/pages/dashboard/home_page.dart';
import 'package:project_test/presentation/pages/dashboard/profile_page.dart';
import 'package:project_test/utils/theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  getUserProfile() {
    final profile = Get.find<ProfileController>();
    profile.getUserDataFromFirestore();
  }

  @override
  void initState() {
    Future.microtask(() {
      getUserProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = Get.find<DashboardController>();

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(defaultMargin)),
        child: BottomNavigationBar(
          backgroundColor: backgroudColor4,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: dashboard.currentIndex,
          onTap: (value) {
            setState(() {
              dashboard.currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 21,
                    color: dashboard.currentIndex == 0
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 18,
                    color: dashboard.currentIndex == 1
                        ? primaryColor
                        : const Color(0xff808191),
                  ),
                ),
                label: ''),
          ],
        ),
      );
    }

    Widget body() {
      switch (dashboard.currentIndex) {
        case 0:
          return const HomePage();

        case 1:
          return const ProfilePage();

        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor:
          dashboard.currentIndex == 0 ? backgroudColor1 : backgroudColor3,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
