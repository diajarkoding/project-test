import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/pages/widget/error_dialog.dart';
import 'package:project_test/routes/route_name.dart';
import 'dart:io';
import 'package:project_test/utils/data_box.dart';

class AuthController extends GetxController {
  final _hive = HiveDataStore();

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  Future<String> _uploadImageToFirebase(File? image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile_photo/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser({
    required String fullName,
    required String email,
    required String password,
    String? gender,
    String? province,
    DateTime? birthDate,
    File? image,
    required BuildContext context,
  }) async {
    FocusScope.of(context).unfocus();

    _isLoading.value = true;

    try {
      String imageUrl = await _uploadImageToFirebase(image);

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'full_name': fullName,
        'email': email,
        'gender': gender,
        'birth_date': birthDate,
        'province': province,
        'profile_photo': imageUrl,
      });

      _isLoading.value = false;

      Get.offAllNamed(Routes.loginPage);
    } catch (e) {
      _isLoading.value = false;

      String errorMessage =
          'Terjadi kesalahan saat melakukan pendaftaran. Silakan coba lagi.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }
      if (context.mounted) {
        errorDialog(context, errorMessage);
      }
    }
  }

  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FocusScope.of(context).unfocus();

    _isLoading.value = true;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;

      _hive.saveUserId(user.uid);

      _hive.saveLogin(true);

      Get.offNamed(Routes.dashboardPage);

      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;

      String errorMessage =
          'Terjadi kesalahan saat melakukan login. Silakan coba lagi.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }
      if (context.mounted) {
        errorDialog(context, errorMessage);
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    _hive.clearLogin();

    Get.offNamed(Routes.loginPage);
  }
}
