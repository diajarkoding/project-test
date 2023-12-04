import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/utils/theme.dart';

Future<dynamic> errorDialog(BuildContext context, String errorMessage) {
  return showDialog(
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'OK',
                style:
                    primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
            ),
          )
        ],
      );
    },
  );
}
