import 'package:flutter/material.dart';
import 'package:project_test/utils/theme.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.usernameController,
    required this.title,
    required this.icon,
    required this.hintText,
    this.marginTop = 20,
    this.obscureText = false,
  });

  final TextEditingController usernameController;
  final String title;
  final String icon;
  final String hintText;
  final double marginTop;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
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
                    icon,
                    width: 17,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: usernameController,
                      obscureText: obscureText,
                      decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
