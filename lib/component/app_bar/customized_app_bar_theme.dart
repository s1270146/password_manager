import 'package:flutter/material.dart';

class CustomizedAppBarTheme extends AppBarTheme {
  const CustomizedAppBarTheme()
      : super(
          backgroundColor: Colors.purple,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
}
