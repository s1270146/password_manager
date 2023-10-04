import 'package:flutter/material.dart';

class CustomizedAppBar extends AppBar {
  CustomizedAppBar({
    Key? key,
    bool automaticallyImplyLeading = true,
    required String title,
    List<Widget>? actions,
  }) : super(
          key: key,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: Text(title),
          actions: actions,
        );
}
