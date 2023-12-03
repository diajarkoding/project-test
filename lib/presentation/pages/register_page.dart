import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/auth_controller.dart';
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
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

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
            'Daftar dan Eksplore Hero MLBB',
            style: subtitleTextStyle,
          ),
        ],
      );
    }

    Widget signUpButton() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: defaultMargin),
        child: ElevatedButton(
          onPressed: () {
            // handleSignUp();
            auth.registerUser(
              fullName: nameController.text,
              email: emailController.text,
              password: passwordController.text,
              context: context,
            );
            // Navigator.pushNamed(context, '/image-profile');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Daftar',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
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
            ),
            CustomInput(
              usernameController: emailController,
              title: 'Email',
              icon: 'assets/icon_email.png',
              hintText: 'Alamat Email',
            ),
            CustomInput(
              usernameController: passwordController,
              title: 'Password',
              icon: 'assets/icon_password.png',
              hintText: 'Password',
              obscureText: true,
            ),
            CustomDropdown(
              title: 'Jenis Kelamin',
              icon: 'assets/icon_username.png',
              items: auth.genderList,
              itemAsString: (item) => item,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    auth.selectedGender = value;
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
            ),
            CustomDropdown(
              title: 'Provinsi',
              icon: 'assets/icon_province.png',
              items: const [],
              asyncItems: (p0) async {
                final List<String> provinces =
                    await ProvinceService().fetchProvinces();

                return provinces;
              },
              itemAsString: (item) => item,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    auth.selectProvince = value;
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
            ),
            selectBirthDay(auth, context),
            uploadPhoto(auth),
            auth.isLoading.value ? const LoadingButton() : signUpButton(),
            const SizedBox(
              height: defaultMargin,
            ),
            footer()
          ],
        ),
      ),
    );
  }

  Padding uploadPhoto(AuthController auth) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unggah Foto',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          auth.image == null
              ? GestureDetector(
                  onTap: () => auth.getImageFromCamera(),
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
              : GestureDetector(
                  onTap: () => auth.getImageFromCamera(),
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
                        backgroundImage: FileImage(auth.image!.value),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Padding selectBirthDay(AuthController auth, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal Lahir',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () => auth.openDatePicker(context),
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
                    auth.selectedDate != null
                        ? Text(
                            formatTanggal(auth.selectedDate.toString()),
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
}
