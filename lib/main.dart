import 'package:flutter/material.dart';

import 'views/animation_two.dart';
import 'views/home_screen.dart';
import 'views/shaders/linear_gradient_shader.dart';
import 'views/shape1.dart';
import 'views/shape2.dart';
import 'views/shape3.dart';
import 'views/shape4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LinearGradientShaderExample(),
    );
  }
}
