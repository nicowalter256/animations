import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SquidGameScreenThree extends StatefulWidget {
  @override
  _SquidGameScreenThreeState createState() => _SquidGameScreenThreeState();
}

class _SquidGameScreenThreeState extends State<SquidGameScreenThree>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late bool isRedLight;
  late List<Player> players;
  late Timer _lightCycleTimer;

  @override
  void initState() {
    super.initState();
    isRedLight = true; // Start with red light
    players = List.generate(
        5,
        (index) => Player(
            startingPosition:
                Random().nextDouble() * 300)); // Create 5 random players

    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..addListener(() {
        setState(() {
          players.forEach((player) {
            player.updatePosition(_controller.value, isRedLight);
          });
        });
      });

    // Start the cycle of switching lights (Red Light -> Green Light -> Red Light)
    _startAnimationCycle();
  }

  void _startAnimationCycle() {
    _lightCycleTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_controller.isCompleted || _controller.isDismissed) {
        if (isRedLight) {
          _controller.forward(from: 0.0);
        } else {
          _controller.reverse(from: _controller.value);
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
    _lightCycleTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isRedLight ? Colors.red : Colors.green,
      body: Center(
        child: CustomPaint(
          painter: GamePainter(players, isRedLight), // Pass isRedLight here
          size: Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}

class Player {
  double position; // Horizontal position of the player
  final double startingPosition; // Initial horizontal position
  bool isFrozen = false;

  Player({required this.startingPosition}) : position = startingPosition;

  // Update player position based on animation and light
  void updatePosition(double animationValue, bool isRedLight) {
    if (!isRedLight) {
      // Move player forward when the light is green
      if (!isFrozen) {
        position = startingPosition +
            animationValue * 300; // 300 is the maximum movement
      }
    } else {
      // Freeze the player when the light is red
      isFrozen = true;
    }
  }

  // Reset player to initial position if needed
  void reset() {
    position = startingPosition;
    isFrozen = false;
  }
}

// Custom painter to draw players and background
class GamePainter extends CustomPainter {
  final List<Player> players;
  final bool isRedLight; // Add isRedLight here

  GamePainter(
      this.players, this.isRedLight); // Accept isRedLight in the constructor

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw each player as a circle and display their state
    for (var player in players) {
      canvas.drawCircle(Offset(player.position, size.height * 0.8), 30, paint);

      // Add the text for each player (whether they are frozen or moving)
      final textPainter = TextPainter(
        text: TextSpan(
          text: player.isFrozen ? "Frozen" : "Moving",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(player.position - 30, size.height * 0.8 + 40));
    }

    // Add status text in the center of the screen
    final statusText = TextPainter(
      text: TextSpan(
        text: isRedLight ? "Red Light!" : "Green Light!",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    statusText.layout();
    statusText.paint(
        canvas, Offset(size.width / 2 - statusText.width / 2, size.height / 4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Redraw the entire canvas for each frame
  }
}
