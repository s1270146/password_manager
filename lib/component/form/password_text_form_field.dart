import 'package:flutter/material.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;

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
      hintText: widget.hintText,
      labelText: "Password *",
      validator: widget.validator,
      obscureText: isObscure,
      suffixIcon: IconButton(
        onPressed: suffixIconOnPressed,
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }
}
