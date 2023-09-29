import 'package:flutter/material.dart';

class CustomizedAppBar extends AppBar {
  CustomizedAppBar({
    Key? key,
    bool automaticallyImplyLeading = true,
    required String title,
  }) : super(
          key: key,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: Text(title),
        );
}
