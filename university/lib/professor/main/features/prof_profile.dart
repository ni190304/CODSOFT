import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Prof_Profile extends StatefulWidget {
  const Prof_Profile({super.key});

  @override
  State<Prof_Profile> createState() => _Prof_ProfileState();
}

class _Prof_ProfileState extends State<Prof_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('profile'),
      ),
    );
  }
}
