import 'dart:math' as math;
import 'package:flutter/material.dart';

class Animated3DSlider extends StatefulWidget {
  @override
  _Animated3DSliderState createState() => _Animated3DSliderState();
}

class _Animated3DSliderState extends State<Animated3DSlider>
    with SingleTickerProviderStateMixin {
  double sliderValue = 0.5;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Controller for the tilt animation.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    // Tween for tilting from 0 to 15 degrees.
    _animation = Tween<double>(begin: 0.0, end: 15.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSliderChange(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTapDown: (_) {
              // Start tilt on press.
              _controller.forward();
            },
            onTapUp: (_) {
              // Reverse tilt when released.
              _controller.reverse();
            },
            onTapCancel: () {
              _controller.reverse();
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                // Apply 3D transformation using Matrix4.
                double tiltAngle = _animation.value;
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..rotateX(tiltAngle * math.pi / 180)
                    ..rotateY(tiltAngle * math.pi / 180),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                // Wrapping Slider with Material ensures proper context for material widgets.
                child: Material(
                  child: Slider(
                    value: sliderValue,
                    onChanged: _onSliderChange,
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Value: ${sliderValue.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
