import 'package:flutter/material.dart';
import 'package:pass_manager/component/app_bar/customized_app_bar.dart';
import 'package:pass_manager/component/button/customized_button.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';
import 'package:pass_manager/component/form/password_text_form_field.dart';
import 'package:pass_manager/component/snack_bar/failed_snack_bar.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';

class PasswordRegistrationScreen extends StatelessWidget {
  PasswordRegistrationScreen({
    Key? key,
    this.title = "Edit Password",
    required this.id,
    required this.uid,
    required this.nameController,
    required this.passwordController,
  }) : super(key: key);

  factory PasswordRegistrationScreen.firstRegister({
    Key? key,
    required String uid,
  }) {
    return PasswordRegistrationScreen(
      id: null,
      uid: uid,
      title: "Register Password",
      nameController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  final String uid;
  final String title;
  final String? id;

  final TextEditingController nameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 97, 0, 148),
      appBar: CustomizedAppBar(
        title: title,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 300,
                child: CustomizedTextFormField(
                  controller: nameController,
                  textColor: Colors.white,
                  icon: const Icon(Icons.badge),
                  iconColor: Colors.white,
                  labelText: "Name of the Password *",
                  hintText: "Enter the name of the password you want register.",
                  borderColor: Colors.white,
                  validator: (String? value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Enter name of the password you want register.';
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: 300,
                child: PasswordTextFormField(
                  controller: passwordController,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  hintText: "Enter the string the password you want register.",
                  borderColor: Colors.white,
                  validator: (String? value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Enter the password you want register.';
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: 100,
                child: CustomizedButton(
                  text: "Register",
                  vertical: 13,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      SuccessSnackBar(
                        text: "The password was registered!",
                        fontSize: 20,
                      ).showSnackBar(context);
                      Navigator.of(context).pop();
                    } else {
                      FailedSnackBar(
                        message: "The password was not able to be registered!",
                        fontSize: 20,
                      ).showSnackBar(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
