import 'package:flutter/material.dart';

class RadialGradientShaderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Radial Gradient Shader")),
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) {
            return RadialGradient(
              colors: [Colors.orange, Colors.purple],
              radius: 0.7,
              center: Alignment.center,
            ).createShader(bounds);
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white, // background color
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: RadialGradientShaderExample()));
}
