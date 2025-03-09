import 'package:flutter/material.dart';

class GestureDrivenAnimationExample extends StatefulWidget {
  @override
  _GestureDrivenAnimationExampleState createState() =>
      _GestureDrivenAnimationExampleState();
}

class _GestureDrivenAnimationExampleState
    extends State<GestureDrivenAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  Offset _position = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _sizeAnimation = Tween<double>(begin: 100, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture-Driven Animation')),
      body: GestureDetector(
        onTap: () {
          // Toggle the animation on tap.
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        onPanUpdate: (details) {
          // Update widget position based on drag.
          setState(() {
            _position += details.delta;
          });
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: _position,
                child: Container(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
