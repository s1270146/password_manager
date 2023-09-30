import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class CustomizedButton extends NeoPopButton {
  CustomizedButton({
    Key? key,
    required String text,
    double? fontSize,
    void Function()? onTap,
    double? vertical,
  }) : super(
          key: key, color: const Color.fromARGB(255, 100, 100, 100),
          bottomShadowColor: Colors.black,
          rightShadowColor: const Color.fromARGB(255, 210, 210, 210),
          // animationDuration: Duration(),
          // depth: kButtonDepth,
          onTapUp: onTap,
          border: Border.all(
            color: Colors.black,
            // width: ,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: vertical ?? 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        );
}
