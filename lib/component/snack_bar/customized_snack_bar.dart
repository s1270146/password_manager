import 'package:flutter/material.dart';

class CustomizedSnackBar extends SnackBar {
  CustomizedSnackBar({
    Key? key,
    required String text,
    double? height,
    double? fontSize,
    Color? backgroundColor,
    int milliseconds = 1000,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          duration: Duration(milliseconds: milliseconds),
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
