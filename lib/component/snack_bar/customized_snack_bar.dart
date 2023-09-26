import 'package:flutter/material.dart';

class CustomizedSnackBar extends SnackBar {
  CustomizedSnackBar({
    Key? key,
    required String text,
    double? height,
    double? fontSize,
    Color? backgroundColor,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          content: SizedBox(
            height: height,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        );
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}
