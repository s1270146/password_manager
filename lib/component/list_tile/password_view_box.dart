import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_manager/component/snack_bar/success_snack_bar.dart';
import 'package:pass_manager/screen/password_registration_screen.dart';

class PasswordViewBox extends StatefulWidget {
  const PasswordViewBox({
    Key? key,
    required this.id,
    required this.uid,
    required this.name,
    required this.password,
    this.width,
    this.height,
    this.margin = 5,
    this.textSize = 14,
  }) : super(
          key: key,
        );
  final String id;
  final String uid;
  final String name;
  final String password;
  final double? width;
  final double? height;
  final double margin;
  final double textSize;

  @override
  State<PasswordViewBox> createState() => _PasswordViewBoxState();
}

class _PasswordViewBoxState extends State<PasswordViewBox> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(widget.margin),
      decoration: BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(10, 15),
          ),
        ],
      ),
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(3),
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: widget.textSize,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isObscure ? "**********" : widget.password,
                  style: TextStyle(
                    fontSize: widget.textSize,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    isObscure = !isObscure;
                  }),
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: widget.password),
                    ).then((value) {
                      SuccessSnackBar(
                        text: "Copied password!",
                        fontSize: 20,
                      ).showSnackBar(context);
                    });
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PasswordRegistrationScreen(
                    id: widget.id,
                    uid: widget.uid,
                    nameController: TextEditingController(text: widget.name),
                    passwordController:
                        TextEditingController(text: widget.password),
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
