import 'package:flutter/material.dart';
import 'dart:math';

class SquidGameShape4Screen extends StatefulWidget {
  @override
  _SquidGameShape4ScreenState createState() => _SquidGameShape4ScreenState();
}

class _SquidGameShape4ScreenState extends State<SquidGameShape4Screen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _circleAnimation;
  late Animation<Offset> _squareAnimation;
  late Animation<Offset> _triangleAnimation;
  late Animation<double> _circleVisibilityAnimation;
  late Animation<double> _squareVisibilityAnimation;
  late Animation<double> _triangleVisibilityAnimation;
  final random = Random();
  bool isRedLight = true;

  @override
  void initState() {
    super.initState();

    // Animation controller for moving shapes
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Shape movement animations (moving in random directions)
    _circleAnimation = _generateRandomAnimation();
    _squareAnimation = _generateRandomAnimation();
    _triangleAnimation = _generateRandomAnimation();

    // Visibility animations to simulate red light/green light
    _circleVisibilityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _squareVisibilityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _triangleVisibilityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Red Light/Green Light simulation
    Future.delayed(Duration(seconds: 2), toggleRedLight);
  }

  // Function to toggle between red and green light (simulate the game rule)
  void toggleRedLight() {
    setState(() {
      isRedLight = !isRedLight;
    });
    // Continue toggling after each interval
    Future.delayed(Duration(seconds: 3), toggleRedLight);
  }

  // Function to generate random animations for shapes' movements
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
        title: Text("Squid Game Simulation four"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: CustomPaint(
          painter: SquidGameShapesPainter(
            _circleAnimation,
            _squareAnimation,
            _triangleAnimation,
            _circleVisibilityAnimation,
            _squareVisibilityAnimation,
            _triangleVisibilityAnimation,
            isRedLight,
          ),
          size: Size(400, 400),
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
  final Animation<double> circleVisibilityAnimation;
  final Animation<double> squareVisibilityAnimation;
  final Animation<double> triangleVisibilityAnimation;
  final bool isRedLight;

  SquidGameShapesPainter(
    this.circleAnimation,
    this.squareAnimation,
    this.triangleAnimation,
    this.circleVisibilityAnimation,
    this.squareVisibilityAnimation,
    this.triangleVisibilityAnimation,
    this.isRedLight,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white; // Default shape color

    // Circle (Red Light -> Disappear when isRedLight)
    if (circleVisibilityAnimation.value > 0) {
      drawCircle(canvas, size, paint);
    }

    // Square (Green Light -> Stay visible, Red Light -> Fade out)
    if (squareVisibilityAnimation.value > 0) {
      drawSquare(canvas, size, paint);
    }

    // Triangle (Switch between Red and Green Light)
    if (triangleVisibilityAnimation.value > 0) {
      drawTriangle(canvas, size, paint);
    }
  }

  // Draw a Circle (represents Guard in the Squid Game)
  void drawCircle(Canvas canvas, Size size, Paint paint) {
    final circlePosition = circleAnimation.value;
    final color =
        isRedLight ? Colors.red : Colors.green; // Red light/Green light effect
    paint.color = color;
    canvas.drawCircle(circlePosition, 50.0, paint);
  }

  // Draw a Square (represents Worker in the Squid Game)
  void drawSquare(Canvas canvas, Size size, Paint paint) {
    final squarePosition = squareAnimation.value;
    final color =
        isRedLight ? Colors.red : Colors.green; // Red light/Green light effect
    paint.color = color;
    final squareRect =
        Rect.fromLTWH(squarePosition.dx, squarePosition.dy, 100, 100);
    canvas.drawRect(squareRect, paint);
  }

  // Draw a Triangle (represents Soldier in the Squid Game)
  void drawTriangle(Canvas canvas, Size size, Paint paint) {
    final trianglePosition = triangleAnimation.value;
    final color =
        isRedLight ? Colors.red : Colors.green; // Red light/Green light effect
    paint.color = color;
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
    return true; // Always repaint to update the movement of shapes
  }
}
