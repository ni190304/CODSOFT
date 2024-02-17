import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Student_Screen extends StatefulWidget {
  const Student_Screen({super.key});

  @override
  State<Student_Screen> createState() => _Student_ScreenState();
}

class _Student_ScreenState extends State<Student_Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Hello student')),
    );
  }
}
