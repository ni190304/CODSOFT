import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Stud_Profile extends StatefulWidget {
  const Stud_Profile({super.key});

  @override
  State<Stud_Profile> createState() => _Stud_ProfileState();
}

class _Stud_ProfileState extends State<Stud_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello stud'),
      ),
    );
  }
}