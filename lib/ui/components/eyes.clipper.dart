import 'package:flutter/material.dart';

//clip de la paupière

class EyeClipper extends CustomClipper<Rect> {
  const EyeClipper();
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.height / 2, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
