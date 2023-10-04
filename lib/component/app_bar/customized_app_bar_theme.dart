import 'package:flutter/material.dart';

class CustomizedAppBarTheme extends AppBarTheme {
  CustomizedAppBarTheme({
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    Color backgroundColor = const Color.fromARGB(255, 21, 0, 80),
  }) : super(
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(
            color: iconColor,
          ),
          titleTextStyle: TextStyle(
            color: textColor,
            fontSize: 24,
          ),
        );
}
