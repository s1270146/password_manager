import 'package:flutter/material.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.iconColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor = Colors.grey,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Color? iconColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color borderColor;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscure = true;
  void suffixIconOnPressed() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomizedTextFormField(
      controller: widget.controller,
      icon: const Icon(Icons.key),
      iconColor: widget.iconColor,
      textColor: widget.textColor,
      hintText: widget.hintText,
      hintColor: widget.hintColor,
      labelText: "Password *",
      labelColor: widget.labelColor,
      validator: widget.validator,
      borderColor: widget.borderColor,
      obscureText: isObscure,
      suffixIcon: IconButton(
        onPressed: suffixIconOnPressed,
        icon: Icon(
          isObscure ? Icons.visibility_off : Icons.visibility,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
