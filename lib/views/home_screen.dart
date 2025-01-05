import 'package:flutter/material.dart';
import 'dart:async';

class SquidGameScreen extends StatefulWidget {
  @override
  _SquidGameScreenState createState() => _SquidGameScreenState();
}

class _SquidGameScreenState extends State<SquidGameScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;
  late bool isRedLight;

  @override
  void initState() {
    super.initState();
    isRedLight = true; // Start with red light
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    // Create a color animation for the background
    _backgroundColor = ColorTween(
      begin: Colors.green, // Green light
      end: Colors.red, // Red light
    ).animate(_controller);

    // Start the cycle
    _startAnimationCycle();
  }

  // This function will toggle between red and green light every 4 seconds
  void _startAnimationCycle() {
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (_controller.isCompleted || _controller.isDismissed) {
        _controller.forward(from: 0.0);
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
      backgroundColor: _backgroundColor.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isRedLight ? "Red Light - Don't Move!" : "Green Light - Move!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRedLight = !isRedLight;
                });
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
