import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Professor_Screen extends StatefulWidget {
  const Professor_Screen({super.key});

  @override
  State<Professor_Screen> createState() => _Professor_ScreenState();
}

class _Professor_ScreenState extends State<Professor_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello professor'),
      ),
    );
  }
}
