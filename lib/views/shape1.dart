import 'package:flutter/material.dart';

class SquidGameShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Squid Game Shapes"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: CustomPaint(
          painter: SquidGameShapesPainter(),
          size: Size(400, 400), // Define the canvas size
        ),
      ),
    );
  }
}

// Custom painter to draw the Squid Game shapes
class SquidGameShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue; // Default shape color

    // Draw the Circle (representing the "O" shape)
    drawCircle(canvas, size, paint);

    // Draw the Square (representing the "□" shape)
    drawSquare(canvas, size, paint);

    // Draw the Triangle (representing the "△" shape)
    drawTriangle(canvas, size, paint);
  }

  // Draw a Circle
  void drawCircle(Canvas canvas, Size size, Paint paint) {
    final circleCenter = Offset(size.width * 0.2, size.height * 0.2);
    final circleRadius = 50.0;
    canvas.drawCircle(circleCenter, circleRadius, paint);
  }

  // Draw a Square
  void drawSquare(Canvas canvas, Size size, Paint paint) {
    final squareRect =
        Rect.fromLTWH(size.width * 0.6, size.height * 0.2, 100, 100);
    canvas.drawRect(squareRect, paint);
  }

  // Draw a Triangle
  void drawTriangle(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width * 0.4,
          size.height * 0.6) // Starting point (top of the triangle)
      ..lineTo(size.width * 0.3, size.height * 0.9) // Bottom left corner
      ..lineTo(size.width * 0.5, size.height * 0.9) // Bottom right corner
      ..close(); // Close the path to form a triangle
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint
  }
}
