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
    Color? iconColor,
    Color? textColor,
    Color? hintColor,
    Color? labelColor,
    Color borderColor = Colors.grey,
    bool obscureText = false,
  }) : super(
          key: key,
          controller: controller,
          style: TextStyle(
            color: textColor,
          ),
          decoration: InputDecoration(
            icon: icon,
            iconColor: iconColor,
            hintText: hintText,
            hintStyle: TextStyle(
              color: textColor ?? hintColor,
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: textColor ?? labelColor,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          validator: validator,
          obscureText: obscureText,
        );
}
