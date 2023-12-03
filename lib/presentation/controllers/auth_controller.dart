import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:project_test/utils/data_box.dart';
import 'package:project_test/utils/theme.dart';

class AuthController extends GetxController {
  String? selectProvince;
  List<String> provinceList = ['Jawa Barat', 'Jakarta', 'Lainnya'];

  List<String> genderList = ['Laki-laki', 'Perempuan', 'Lainnya'];
  String? selectedGender;

  Rx<bool> _isLoading = false.obs;
  Rx<bool> get isLoading => _isLoading;

  Rx<DateTime>? _selectedDate;
  Rx<DateTime>? get selectedDate => _selectedDate;

  final _picker = ImagePicker();

  final _hive = HiveDataStore();

  Rx<File>? _image;
  Rx<File>? get image => _image;

  Future<void> openDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: initialDate,
    );

    if (pickedDate != null) {
      _selectedDate!.value = pickedDate;
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image!.value = File(pickedFile.path);
    }
  }

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
    required BuildContext context,
  }) async {
    _isLoading.value = true;

    try {
      String imageUrl = await _uploadImageToFirebase(image!.value);

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'full_name': fullName,
        'email': email,
        'gender': selectedGender,
        'birth_date': selectedDate,
        'province': selectProvince,
        'profile_photo': imageUrl,
      });

      _isLoading.value = false;

      if (context.mounted) {
        Navigator.pushNamed(context, '/signin');
      }
    } catch (e) {
      _isLoading.value = false;

      String errorMessage =
          'Terjadi kesalahan saat melakukan pendaftaran. Silakan coba lagi.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: backgroudColor3,
              title: Text(
                'Error',
                style: primaryTextStyle,
              ),
              content: Text(
                errorMessage,
                style: primaryTextStyle,
              ),
              actions: [
                Container(
                  width: double.infinity,
                  height: 44,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    }
  }

  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
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

      _isLoading.value = false;

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      _isLoading.value = false;

      String errorMessage =
          'Terjadi kesalahan saat melakukan login. Silakan coba lagi.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: backgroudColor3,
              title: Text(
                'Error',
                style: primaryTextStyle,
              ),
              content: Text(
                errorMessage,
                style: primaryTextStyle,
              ),
              actions: [
                Container(
                  width: double.infinity,
                  height: 44,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    _hive.clearLogin();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }
}
