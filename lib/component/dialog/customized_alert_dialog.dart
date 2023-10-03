import 'package:flutter/material.dart';

class CustomizedAlertDialog extends AlertDialog {
  CustomizedAlertDialog({
    Key? key,
    String? title,
    Widget? content,
    void Function()? onPressedOfPossitive,
    void Function()? onPressedOfNegative,
  }) : super(
          key: key,
          title: title != null ? Center(child: Text(title)) : null,
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: onPressedOfPossitive,
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: onPressedOfNegative,
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
}
