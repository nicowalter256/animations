import 'package:flutter/material.dart';

class GradientShaderMaskExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gradient Shader Mask")),
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green, Colors.purple],
            ).createShader(bounds);
          },
          child: Container(
            width: 300,
            height: 300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: GradientShaderMaskExample()));
}
