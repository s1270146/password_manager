import 'package:flutter/material.dart';
import 'package:pass_manager/component/snack_bar/customized_snack_bar.dart';

class SuccessSnackBar extends CustomizedSnackBar {
  SuccessSnackBar({
    Key? key,
    required String text,
    double? height,
    double? fontSize,
  }) : super(
          key: key,
          text: "Success! $text",
          backgroundColor: Colors.green,
          height: height,
          fontSize: fontSize,
        );
}
