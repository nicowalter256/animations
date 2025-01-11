import 'dart:math';

import 'package:flutter/material.dart';

class SpiralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double angle = 0.0;
    double radius = 0.0;

    // Draw a spiral
    while (radius < size.width / 2) {
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      if (angle == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      angle += 0.2; // Change angle to create the spiral
      radius += 2; // Increase radius as the spiral grows
    }

    // Draw the spiral path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
