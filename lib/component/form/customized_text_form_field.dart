import 'package:flutter/material.dart';

class CustomizedTextFormField extends TextFormField {
  CustomizedTextFormField({
    Key? key,
    TextEditingController? controller,
    Icon? icon,
    String? hintText,
    String? labelText,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    bool obscureText = false,
  }) : super(
          key: key,
          controller: controller,
          decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          obscureText: obscureText,
        );
}
