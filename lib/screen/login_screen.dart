import 'package:flutter/material.dart';
import 'package:pass_manager/component/button/customized_button.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';
import 'package:pass_manager/component/form/password_text_form_field.dart';
import 'package:pass_manager/component/snack_bar/failed_snack_bar.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';
import 'package:pass_manager/screen/password_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 300,
                    child: CustomizedTextFormField(
                      controller: emailController,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your registered email address',
                      labelText: 'Email *',
                      validator: (String? value) {
                        return (value != null && (value.contains('@')))
                            ? null
                            : 'Enter a email. Use the @ char.';
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 300,
                    child: PasswordTextFormField(
                      controller: passController,
                      hintText: 'Enter your password',
                      validator: (String? value) {
                        return (value != null && value.isNotEmpty)
                            ? null
                            : 'Enter your password';
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 100,
              child: CustomizedButton(
                text: "Log In",
                vertical: 15,
                onTap: () {
                  if (_loginFormKey.currentState!.validate()) {
                    SuccessSnackBar(
                      text: "You are Logged In!",
                      fontSize: 20,
                    ).showSnackBar(context);
                    String uid = "test_id";
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PasswordListScreen(
                          uid: uid,
                        ),
                      ),
                    );
                  } else {
                    FailedSnackBar(
                      message: "You cloud not Log In!",
                      fontSize: 20,
                    ).showSnackBar(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
