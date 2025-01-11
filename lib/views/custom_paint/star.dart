import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Define the star points
    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width * 0.6, size.height * 0.8);
    path.lineTo(0, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width * 0.4, size.height * 0.8);
    path.close(); // Closing the path to form a star

    // Draw the star
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
