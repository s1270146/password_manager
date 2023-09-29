import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';
import 'package:pass_manager/screen/password_registration_screen.dart';

class PasswordViewBox extends StatelessWidget {
  const PasswordViewBox({
    Key? key,
    required this.id,
    required this.uid,
    required this.name,
    required this.password,
    this.width,
    this.height,
  }) : super(
          key: key,
        );
  final String id;
  final String uid;
  final String name;
  final String password;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Text(name),
          Text(password),
          IconButton(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: password),
              ).then((value) {
                SuccessSnackBar(
                  text: "Copied password!",
                  fontSize: 20,
                ).showSnackBar(context);
              });
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PasswordRegistrationScreen(
                        id: id,
                        uid: uid,
                        nameController: TextEditingController(text: name),
                        passwordController:
                            TextEditingController(text: password),
                      ),
                    ),
                  ),
              icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
