import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/auth_controller.dart';
import 'package:project_test/presentation/pages/widget/custom_input.dart';
import 'package:project_test/utils/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    final auth = Get.find<AuthController>();

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar',
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

    Widget registerButton() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(top: defaultMargin),
        child: ElevatedButton(
          onPressed: () => auth.register(
              email: emailController.text, password: passwordController.text),
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
            onPressed: () => Get.back(),
            child: Text(
              ' Login',
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
              registerButton(),
              const Spacer(),
              footer()
            ],
          ),
        ),
      ),
    );
  }
}
