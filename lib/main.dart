import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_test/routes/app_page.dart';
import 'package:project_test/routes/route_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_test/utils/data_box.dart';
import 'firebase_options.dart';

FutureOr<void> main() async {
  final dataBox = HiveDataStore();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // init hive datasore
  await dataBox.init();
  await dataBox.setHiveBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HiveDataStore().initSecureBox();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: Routes.loginPage,
    );
  }
}
