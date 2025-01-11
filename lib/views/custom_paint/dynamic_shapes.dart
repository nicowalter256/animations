import 'package:flutter/material.dart';

class AnimatedCirclePainter extends StatefulWidget {
  @override
  _AnimatedCirclePainterState createState() => _AnimatedCirclePainterState();
}

class _AnimatedCirclePainterState extends State<AnimatedCirclePainter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat and reverse the animation

    _animation = Tween<double>(begin: 50, end: 150).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Circle')),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: CirclePainter(_animation),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;

  CirclePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw the animated circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      animation.value,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint whenever the animation value changes
  }
}
