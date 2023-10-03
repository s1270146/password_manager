import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/component/app_bar/customized_app_bar.dart';
import 'package:pass_manager/component/button/customized_button.dart';
import 'package:pass_manager/component/dialog/customized_alert_dialog.dart';
import 'package:pass_manager/component/form/customized_text_form_field.dart';
import 'package:pass_manager/component/form/password_text_form_field.dart';
import 'package:pass_manager/component/snack_bar/failed_snack_bar.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';
import 'package:pass_manager/provider/list_provider.dart';
import 'package:pass_manager/provider/supabase_provider.dart';

class PasswordRegistrationScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseProvider);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: id != null,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomizedAlertDialog(
                            title: "Delete Password?",
                            onPressedOfPossitive: () async {
                              await supabase
                                  .from('password')
                                  .delete()
                                  .eq('id', id!);
                              if (!context.mounted) return;
                              ref.invalidate(passwordListProvider);
                              SuccessSnackBar(
                                text: "Delete Password!",
                                fontSize: 20,
                              ).showSnackBar(context);
                              int count = 0;
                              Navigator.popUntil(context, (_) => count++ >= 2);
                            },
                            onPressedOfNegative: () =>
                                Navigator.of(context).pop(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 100,
                    child: CustomizedButton(
                      text: "Register",
                      vertical: 13,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (id != null) {
                            await supabase.from('password').update({
                              "password": passwordController.text,
                              "name": nameController.text,
                            }).match({
                              "id": id,
                            });
                          } else {
                            await supabase.from('password').insert({
                              "name": nameController.text,
                              "password": passwordController.text,
                              "uid": uid,
                            });
                          }
                          if (!context.mounted) return;
                          SuccessSnackBar(
                            text: "The password was registered!",
                            fontSize: 20,
                          ).showSnackBar(context);
                          ref.invalidate(passwordListProvider);
                          Navigator.of(context).pop();
                        } else {
                          FailedSnackBar(
                            message:
                                "The password was not able to be registered!",
                            fontSize: 20,
                          ).showSnackBar(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
