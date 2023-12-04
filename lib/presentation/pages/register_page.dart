import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_test/presentation/controllers/auth_controller.dart';
import 'package:project_test/presentation/pages/widget/custom_button.dart';
import 'package:project_test/presentation/pages/widget/custom_dropdown.dart';
import 'package:project_test/presentation/pages/widget/custom_input.dart';
import 'package:project_test/presentation/pages/widget/loading_button.dart';
import 'package:project_test/services/province_service.dart';
import 'package:project_test/utils/format.dart';
import 'package:project_test/utils/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  final picker = ImagePicker();

  String? selectProvince;
  List<String> provinceList = ['Jawa Barat', 'Jakarta', 'Lainnya'];
  List<String> genderList = ['Laki-laki', 'Perempuan'];
  String? selectedGender;
  DateTime? selectedDate;
  File? image;

  String? _nameValidator(_) {
    if (nameController.text.isEmpty) {
      return "Nama belum diisi";
    }
    if (nameController.text.length < 3) {
      return "Format nama belum sesuai";
    }
    return null;
  }

  String? _emailValidator(_) {
    String email = emailController.text;
    final bool isEmailValid = EmailValidator.validate(email);
    if (email.isEmpty) {
      return "Email belum terisi";
    }
    if (!isEmailValid) {
      return "Format email belum benar";
    }
    return null;
  }

  String? _passwordValidator(_) {
    String password = passwordController.text;
    if (password.isEmpty) {
      return "Kata sandi belum terisi";
    }
    if (password.length < 8) {
      return "Kata sandi minimal 8 karakter";
    }

    return null;
  }

  Future<void> openDatePicker() async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: initialDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  register() {
    final loginFormState = _formKey.currentState!;
    final auth = Get.find<AuthController>();
    if (loginFormState.validate()) {
      auth.registerUser(
        fullName: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        gender: selectedGender,
        province: selectProvince,
        birthDate: selectedDate,
        image: image,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign Up',
            style:
                primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
          ),
          Text(
            'Daftar untuk membuat akun',
            style: subtitleTextStyle,
          ),
        ],
      );
    }

    CustomDropdown chooseGender() {
      return CustomDropdown(
        title: 'Jenis Kelamin',
        icon: 'assets/icon_username.png',
        items: genderList,
        itemAsString: (item) => item,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedGender = value;
            });
          }
        },
        dropdownBuilder: (context, selectedItem) {
          return selectedItem == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'Pilih Jenis Kelamin',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16.2,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    selectedItem,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16.2,
                    ),
                  ),
                );
        },
      );
    }

    CustomDropdown chooseProvince() {
      return CustomDropdown(
        title: 'Provinsi',
        icon: 'assets/icon_province.png',
        items: const [],
        asyncItems: (_) async {
          final List<String> provinces =
              await ProvinceService().fetchProvinces();

          return provinces;
        },
        itemAsString: (item) => item,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectProvince = value;
            });
          }
        },
        dropdownBuilder: (context, selectedItem) {
          return selectedItem == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'Pilih Provinsi',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16.2,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Text(
                    selectedItem,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16.2,
                    ),
                  ),
                );
        },
      );
    }

    Padding selectBirthDay(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Lahir',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () => openDatePicker(),
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: backgroudColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_date.png',
                        width: 17,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      selectedDate != null
                          ? Text(
                              formatTanggal(selectedDate.toString()),
                              style: primaryTextStyle.copyWith(
                                fontSize: 15.5,
                              ),
                            )
                          : Text(
                              'Tanggal Lahir',
                              style: subtitleTextStyle.copyWith(
                                fontSize: 15.5,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Padding uploadPhoto() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unggah Foto',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            if (image == null)
              GestureDetector(
                onTap: () => getImageFromCamera(),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: backgroudColor2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/image_profile.png'),
                    ),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () => getImageFromCamera(),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: backgroudColor2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(image!),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sudah punya akun?",
            style: subtitleTextStyle.copyWith(fontSize: 14),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signin'),
            child: Text(
              ' Sign In',
              style: purpleTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroudColor1,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        child: Obx(
          () => Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                header(),
                CustomInput(
                  usernameController: nameController,
                  title: 'Nama Lengkap',
                  icon: 'assets/icon_name.png',
                  hintText: 'Nama Lengkap',
                  marginTop: 70,
                  validator: _nameValidator,
                ),
                CustomInput(
                  usernameController: emailController,
                  title: 'Email',
                  icon: 'assets/icon_email.png',
                  hintText: 'Alamat Email',
                  validator: _emailValidator,
                ),
                CustomInput(
                  usernameController: passwordController,
                  title: 'Password',
                  icon: 'assets/icon_password.png',
                  hintText: 'Password',
                  obscureText: true,
                  validator: _passwordValidator,
                ),
                chooseGender(),
                chooseProvince(),
                selectBirthDay(context),
                uploadPhoto(),
                if (auth.isLoading.isTrue)
                  const LoadingButton()
                else
                  CustomButton(
                    onPressed: register,
                    title: 'Daftar',
                  ),
                const SizedBox(
                  height: defaultMargin,
                ),
                footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
