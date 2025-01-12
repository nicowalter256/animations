import 'package:flutter/material.dart';

class LinearGradientShaderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Linear Gradient Shader")),
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.red],
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
  runApp(MaterialApp(home: LinearGradientShaderExample()));
}
