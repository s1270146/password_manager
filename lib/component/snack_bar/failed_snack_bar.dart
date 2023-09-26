import 'package:flutter/material.dart';
import 'package:pass_manager/component/snack_bar/customized_snack_bar.dart';

class FailedSnackBar extends CustomizedSnackBar {
  FailedSnackBar({
    Key? key,
    required String message,
    double? height,
    double? fontSize,
  }) : super(
          key: key,
          text: "Failed! $message",
          backgroundColor: Colors.red,
          height: height,
          fontSize: fontSize,
        );
}
