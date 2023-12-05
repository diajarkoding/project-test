import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/auth_controller.dart';
import 'package:project_test/presentation/pages/widget/custom_button.dart';
import 'package:project_test/presentation/pages/widget/custom_input.dart';
import 'package:project_test/presentation/pages/widget/loading_button.dart';
import 'package:project_test/routes/route_name.dart';
import 'package:project_test/utils/theme.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

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

  login() {
    final loginFormState = _formKey.currentState!;
    final auth = Get.find<AuthController>();
    FocusScope.of(context).unfocus();
    if (loginFormState.validate()) {
      auth.loginUser(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }
  }

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
          child: Obx(
            () => Form(
              key: _formKey,
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
                  if (auth.isLoading.isTrue)
                    const LoadingButton()
                  else
                    CustomButton(
                      onPressed: login,
                      title: 'Masuk',
                    ),
                  const Spacer(),
                  footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
