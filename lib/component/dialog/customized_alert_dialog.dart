import 'package:flutter/material.dart';

class CustomizedAlertDialog extends AlertDialog {
  CustomizedAlertDialog({
    Key? key,
    String? title,
    double titleFontSize = 28,
    double actionsFontSize = 24,
    Widget? content,
    void Function()? onPressedOfPossitive,
    void Function()? onPressedOfNegative,
  }) : super(
          key: key,
          title: title != null
              ? Center(
                  child: Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                  ),
                ))
              : null,
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: onPressedOfPossitive,
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: actionsFontSize,
                ),
              ),
            ),
            TextButton(
              onPressed: onPressedOfNegative,
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: actionsFontSize,
                ),
              ),
            ),
          ],
        );
}
