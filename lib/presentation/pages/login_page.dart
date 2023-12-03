import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/pages/widget/custom_input.dart';
import 'package:project_test/routes/route_name.dart';
import 'package:project_test/utils/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style:
                primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
          ),
          Text(
            'Masuk untuk Melanjutkan',
            style: subtitleTextStyle,
          ),
        ],
      );
    }

    Widget signInButton() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: defaultMargin),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Masuk',
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
            "Belum punya akun?",
            style: subtitleTextStyle.copyWith(fontSize: 14),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.registerPage),
            child: Text(
              ' Daftar',
              style: purpleTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroudColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              CustomInput(
                usernameController: emailController,
                title: 'Email ',
                icon: 'assets/icon_email.png',
                hintText: 'Alamat Email',
                marginTop: 70,
              ),
              CustomInput(
                usernameController: passwordController,
                title: 'Password',
                icon: 'assets/icon_password.png',
                hintText: 'Password',
                obscureText: true,
              ),
              signInButton(),
              const Spacer(),
              footer()
            ],
          ),
        ),
      ),
    );
  }
}
