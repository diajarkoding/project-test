import 'package:flutter/material.dart';
import 'package:project_test/utils/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 4),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(primaryTextColor),
              ),
            ),
            Text(
              'Loading',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }
}
