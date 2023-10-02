import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/component/button/customized_button.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';
import 'package:pass_manager/component/form/password_text_form_field.dart';
import 'package:pass_manager/component/snack_bar/failed_snack_bar.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';
import 'package:pass_manager/provider/supabase_provider.dart';
import 'package:pass_manager/screen/password_list_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseProvider);
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
                onTap: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    try {
                      final User? currentUser = supabase.auth.currentUser;
                      if (currentUser != null) {
                        supabase.auth.signOut();
                      }
                      final res = await supabase.auth.signInWithPassword(
                        email: emailController.text,
                        password: passController.text,
                      );
                      final user = res.user;
                      if (!context.mounted) return;
                      if (user != null) {
                        SuccessSnackBar(
                          text: "You are Logged In!",
                          fontSize: 20,
                        ).showSnackBar(context);
                        String uid = user.id;
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
                    } on AuthException catch (e) {
                      if (!context.mounted) return;
                      FailedSnackBar(
                        message: "Invalid email or password!",
                        fontSize: 20,
                      ).showSnackBar(context);
                      print(e);
                    } on Exception catch (e) {
                      if (!context.mounted) return;
                      FailedSnackBar(
                        message: "System Exception!",
                        fontSize: 20,
                      ).showSnackBar(context);
                      print(e);
                    } finally {
                      FailedSnackBar(
                        message: "System Error!",
                        fontSize: 20,
                      ).showSnackBar(context);
                    }
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
