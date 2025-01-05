import 'package:flutter/material.dart';
import 'dart:async';

class SquidGameScreenTwo extends StatefulWidget {
  @override
  _SquidGameScreenTwoState createState() => _SquidGameScreenTwoState();
}

class _SquidGameScreenTwoState extends State<SquidGameScreenTwo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _playerMovementAnimation;
  late bool isRedLight;

  double _playerPosition = 0.0; // Player's horizontal position

  @override
  void initState() {
    super.initState();
    isRedLight = true; // Start with red light

    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..addListener(() {
        setState(() {
          _playerPosition = _playerMovementAnimation.value;
        });
      });

    _playerMovementAnimation = Tween<double>(
      begin: 0.0,
      end: 300.0, // 300 pixels of movement
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // Start the cycle
    _startAnimationCycle();
  }

  // This function will toggle between red and green light every 4 seconds
  void _startAnimationCycle() {
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (_controller.isCompleted || _controller.isDismissed) {
        if (isRedLight) {
          _controller.forward(from: 0.0);
        } else {
          _controller.reverse(from: _playerMovementAnimation.value);
        }
        setState(() {
          isRedLight = !isRedLight;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isRedLight ? Colors.red : Colors.green,
      body: Center(
        child: CustomPaint(
          painter: PlayerPainter(_playerPosition, isRedLight),
          size: Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}

// Custom painter to draw the player
class PlayerPainter extends CustomPainter {
  final double playerPosition;
  final bool isRedLight;

  PlayerPainter(this.playerPosition, this.isRedLight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the player as a circle (you can customize the character here)
    canvas.drawCircle(Offset(playerPosition, size.height * 0.8), 30, paint);

    // Draw text indicating the current light color
    final textPaint = TextPainter(
      text: TextSpan(
        text: isRedLight ? "Red Light!" : "Green Light!",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPaint.layout();
    textPaint.paint(
        canvas, Offset(size.width / 2 - textPaint.width / 2, size.height / 4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Redraw on every frame
  }
}
