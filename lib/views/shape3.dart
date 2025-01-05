import 'package:flutter/material.dart';
import 'dart:math';

class SquidGameShape3Screen extends StatefulWidget {
  @override
  _SquidGameShape3ScreenState createState() => _SquidGameShape3ScreenState();
}

class _SquidGameShape3ScreenState extends State<SquidGameShape3Screen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _circleAnimation;
  late Animation<Offset> _squareAnimation;
  late Animation<Offset> _triangleAnimation;
  final random = Random();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )
      ..addListener(() {
        setState(() {}); // Rebuild on each animation tick
      })
      ..repeat(); // Repeat the animation infinitely

    // Animations for each shape, moving in random directions
    _circleAnimation = _generateRandomAnimation();
    _squareAnimation = _generateRandomAnimation();
    _triangleAnimation = _generateRandomAnimation();
  }

  // Function to generate random animations for each shape
  Animation<Offset> _generateRandomAnimation() {
    final endOffset =
        Offset(random.nextDouble() * 300, random.nextDouble() * 400);
    return Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: endOffset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moving Squid Game Shapes"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: CustomPaint(
          painter: SquidGameShapesPainter(
            _circleAnimation,
            _squareAnimation,
            _triangleAnimation,
          ),
          size: Size(400, 400), // Define the canvas size
        ),
      ),
    );
  }
}

// Custom painter to draw and animate Squid Game shapes
class SquidGameShapesPainter extends CustomPainter {
  final Animation<Offset> circleAnimation;
  final Animation<Offset> squareAnimation;
  final Animation<Offset> triangleAnimation;

  SquidGameShapesPainter(
      this.circleAnimation, this.squareAnimation, this.triangleAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red; // Default shape color

    // Draw the Circle
    drawCircle(canvas, size, paint);

    // Draw the Square
    drawSquare(canvas, size, paint);

    // Draw the Triangle
    drawTriangle(canvas, size, paint);
  }

  // Draw a Circle
  void drawCircle(Canvas canvas, Size size, Paint paint) {
    final circlePosition = circleAnimation.value;
    canvas.drawCircle(circlePosition, 50.0, paint);
  }

  // Draw a Square
  void drawSquare(Canvas canvas, Size size, Paint paint) {
    final squarePosition = squareAnimation.value;
    final squareRect =
        Rect.fromLTWH(squarePosition.dx, squarePosition.dy, 100, 100);
    canvas.drawRect(squareRect, paint);
  }

  // Draw a Triangle
  void drawTriangle(Canvas canvas, Size size, Paint paint) {
    final trianglePosition = triangleAnimation.value;
    final path = Path()
      ..moveTo(trianglePosition.dx,
          trianglePosition.dy) // Starting point (top of the triangle)
      ..lineTo(trianglePosition.dx + 50,
          trianglePosition.dy + 100) // Bottom left corner
      ..lineTo(trianglePosition.dx - 50,
          trianglePosition.dy + 100) // Bottom right corner
      ..close(); // Close the path to form a triangle
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint
  }
}
