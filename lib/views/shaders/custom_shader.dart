import 'package:flutter/material.dart';

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class GradientShaderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gradient Shader Example")),
      body: CustomPaint(
        size: Size(300, 300),
        painter: GradientPainter(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: GradientShaderExample()));
}
