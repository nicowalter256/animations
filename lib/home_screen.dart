import 'package:flutter/material.dart';

class MountainViewPage extends StatefulWidget {
  @override
  _MountainViewPageState createState() => _MountainViewPageState();
}

class _MountainViewPageState extends State<MountainViewPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation; // Specify the type here

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward(); // Start the animation
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
        title: Text('Mountain View Animation'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child:
              Image.asset('assets/mountain.jpeg'), // Mountain image in assets
        ),
      ),
    );
  }
}
