import 'package:flutter/material.dart';

//painter pour la forme de l'œil

class EyeBackGroundPainter extends CustomPainter {
  EyeBackGroundPainter({
    required this.backgroundColor,
    required this.borderColor,
    this.angle = 0,
    this.borderWidth = 3,
  });
  Path path = Path();
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect oval = Rect.fromLTWH(0, 0, size.height / 2, size.height);
    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    path.addOval(oval);

    canvas.rotate(angle);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool hitTest(Offset position) {
    final hit = path.contains(position);
    return hit;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
